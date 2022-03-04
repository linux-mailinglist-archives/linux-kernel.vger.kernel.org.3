Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FF64CD419
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiCDMNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiCDMNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:13:50 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA7C522D5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:13:02 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2dc348dab52so55217877b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 04:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JvzcxTknwlUai69GZXDhvioqVy0LFPbimbqbpKC7sU=;
        b=KFv2TBYrhqFCyh9zxS3Khdu/BprRqhhGAFMToRO/GTUV6XkpMaUMJ63nL9htyZuw2S
         pOiWl/uYc8I3mpfFIDjNmfTZYmM9mQgTtdr15mHm+oszhlJlFwpllDhWomNTf7rAxQCx
         RUAjS1J/iBhBOltRfp5C1VNosMIz/Ufrd+JSkdPbckiw2Cz12cBSLofcFLTtZR1w2+Ib
         4lq93gyf1EW23HNVun8RPRcEbqDp6jQNLQi/2aurA635tRFhrtUKglOd7rrsG1r+2YrF
         qDPVfl/x9Yo9VguqFqEHK5Osvcle3bGY9SzmLF3+W3Ghkm9jin+EvniE2vVYQZ/4FqlM
         QRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JvzcxTknwlUai69GZXDhvioqVy0LFPbimbqbpKC7sU=;
        b=opAPveJTMvUFNOhCy4dEX4Cph5v2dSxnsDE9ZBgNMXT68KoOBZDK6tI18PvENy34ya
         VE7SnqHSTxnBaPF7XAk3N7rtqbIAATq8f4rpy0tO4SOUB2EtdpSTxG0tT2zlGKrzIykB
         XSPfXlq43x2b+3bpnvIR0mzYHCRQdx9U47if9Meyr4tW8uKO03s5DK7DPgx24ZiKl/aO
         aoGnuUtLVRwZMT6B0WZykTAeYnq3t4MHFWLKSwgEl9KIp9QokR6BGVqaEtWAPryC9pD5
         zU0j5AN6pOlWfDTJ+5I6TZufA7dan11OYGrn6NhjLzwB5huyrXXvLSatNhFbO5nlLnNH
         b39A==
X-Gm-Message-State: AOAM532vRemYf4Sl6QNMjMgOY1KueZa1luvMrcZ6QyR2pyKgulGs2/jD
        rMas9l4/1qdLMyRkqiw6yjGELolNxZuV1A4DnLxMIw==
X-Google-Smtp-Source: ABdhPJziwXxOZZVl2v933uVLwYm7jbJc511Fad/VKCHXW/JLH9SL1Jxwbuj7jKp4wNeCWEoYnmMPB90DziNdWrVOvD0=
X-Received: by 2002:a0d:f9c5:0:b0:2db:7a9a:b01a with SMTP id
 j188-20020a0df9c5000000b002db7a9ab01amr24748839ywf.458.1646395981338; Fri, 04
 Mar 2022 04:13:01 -0800 (PST)
MIME-Version: 1.0
References: <20220304093409.25829-1-linmiaohe@huawei.com> <20220304093409.25829-3-linmiaohe@huawei.com>
In-Reply-To: <20220304093409.25829-3-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 4 Mar 2022 20:12:13 +0800
Message-ID: <CAMZfGtXdy73Bq==ioWxnFpWnYqftzotxwPD+YTABHfERqBz7Xg@mail.gmail.com>
Subject: Re: [PATCH 02/16] mm/migration: remove unneeded out label
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        ave.hansen@linux.intel.com, o451686892@gmail.com,
        Mina Almasry <almasrymina@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Michal Hocko <mhocko@suse.com>,
        riel@redhat.com, Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 5:35 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> We can do prep_transhuge_page when newpage is not NULL. Thus we can remove
> out label to simplify the code.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
