Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86C35A7065
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiH3WLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiH3WLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:11:01 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710C54C601;
        Tue, 30 Aug 2022 15:10:59 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id b81so5945639vkf.1;
        Tue, 30 Aug 2022 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=leKLJzHs8uZWkvtY7eIUy5dp8f7s29BRffRzphxIp1A=;
        b=SDMhPai0I4WEgO8cPsu8tEJ/y/zJBv3TY0/TsDAH49nmJ8YRjv4bnPbFhn0XSI3REn
         QRDYbuaIgFuTpbDWwB0ROCKxEgcTMeMcUVytNMHnwF2aJl47Rf4rjiQhsOOoFG3dFl9Y
         peGhGjl1clM9uizjj1ZL8abbpD9t9RVRgaJnJQUGBelxVo2yglCEiDc/D8KFEDgB35JE
         c/4QZZXOvve3zVg9L/KQ7xcQMFuoZh146SgVTnyAaRDBuwAW2EWhQHJ0PRNBZXaLvFPX
         BdLKimfaaHIW+vpixZnkQId80Q8cHf5YPhQBjQwk9b0LFpgN0+JMpuyt5rOd42jVNHhc
         a0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=leKLJzHs8uZWkvtY7eIUy5dp8f7s29BRffRzphxIp1A=;
        b=LD8aOHOzze6npk+fb7SXYCwzlL/leOYwsLOaU27Okg9ympFbz/JjDf0mrX8qfhXZUO
         NzhQKHCEBJKAjXPr5OSKN4SzuwWVlHczM2tgZOrHfLLDCoIFjfgejqQm9AzlQpw/0+st
         QLIt22hbBagcJ+SLIqxqEiucCIwLWhFSmrJ1832nIdO3w2fbzp/g/K1xIdWCKcl6fW9f
         v/COY14affGUM2vD+ynUiJMF7kzehvhVEBC9JF/vF+BpBiNgshQTfujABlhdIEUHbjp5
         HRIO9VLgTt8CBepWt7eR/JkcObtSDAWLM5JJGafRho30WBn2Mj6Yoo/fk/HTEuABMNsF
         Ni4Q==
X-Gm-Message-State: ACgBeo3e85hg6sJFbTZ9mXSaaH99v6mW1Jg+OX5Z2YrzmfBOnVdT+hdK
        yNvnFIx+lh2WXkvw0ZNW/J/FHwmwiJbaFlxLJ4fHKD1kStI=
X-Google-Smtp-Source: AA6agR4zQ1I1seEH9HNBSdTd7Zbneffor1ohNA5t41exvIyTWSKYvzKoUr4lqASO6oUFEPzk/zaRccBk1/EwLN5+JXM=
X-Received: by 2002:a1f:ab4e:0:b0:394:5af3:c490 with SMTP id
 u75-20020a1fab4e000000b003945af3c490mr4012825vke.24.1661897458362; Tue, 30
 Aug 2022 15:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220831074247.5ae119a3@canb.auug.org.au>
In-Reply-To: <20220831074247.5ae119a3@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 30 Aug 2022 17:10:47 -0500
Message-ID: <CAH2r5muWkiYDNXUibC6RR9s0rTYda2zDGpJhTpnpG7PMBXhh-Q@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry about the cut-n-paste error

fixed

On Tue, Aug 30, 2022 at 4:42 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   ebcc8ccc13e0 ("smb3: use filemap_write_and_wait_range instead of filemap_write_and_wait")
>
> Fixes tag
>
>   Fixes: c3a72bb21320 ("Reviewed-by: David Howells <dhowells@redhat.com>")
>
> has these problem(s):
>
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format='Fixes: %h ("%s")'
>
> So,
>
> Fixes: c3a72bb21320 ("smb3: Move the flush out of smb2_copychunk_range() into its callers")
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
