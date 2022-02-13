Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18484B3B30
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 12:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiBMLxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 06:53:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiBMLxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 06:53:02 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E865B899;
        Sun, 13 Feb 2022 03:52:57 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id d7so12640325qvk.2;
        Sun, 13 Feb 2022 03:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypYEF45YCKKIdDHjouvAAAG2lyLXjqrY5CQNbYfOknI=;
        b=eCWqTkpsETaYEeYsA3m2vj0uiea0laWiSjLkPRnEacous6O7JrnYslxdn9MpoN8Obs
         s+B3MBv63Dnx7s20W42vyg3UX4WzcYykSspy2ODntZgUagiy2HWLggZhF1pnJKYqvHze
         XsVQJiMAAP3QLt8pX2HJdbfmcQYbamp1ivzc7aFa+Sr/OEtNV3LCdV7mUnMUwFrHIu7S
         j3tn9BBwgQityJvJzcvcynEeQZNxh5rsHW3aZWTmzp1OsXQNUT60w8wYkKh38xNxDugA
         rkMIPk1AWlSB9NYgACXKcA7s+opSaXWDHjfW5hO3Q3Nh8PEfpFULip27pT+ev306nASd
         A0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypYEF45YCKKIdDHjouvAAAG2lyLXjqrY5CQNbYfOknI=;
        b=34r/o31UXMcgSPSTzECXsZOutJ8/dXKBkieTFfXGHCm/wrBHJqdxKbYp+x3A1+Rb08
         NckGn4jbnzho9Bq7cJJCAOiK6Wokwq81CTdNy8MwzCHu2ILAICfa/P8S6BQetMe2ezz6
         fCIO05JWNOj0Q6Jqq7FmTBjohPTrwrE7kZlKWVdsSVqJDy024kY5hsctLVJBmQru7WiD
         0BB+GFxkNNSPCGhtRPOrrjTpV4GM63CGnqBxrqP7qraW0ZlFXxYid7qzrT3/V3KMV8Er
         ulqG4eKYridasg4aWfPNcXX5Tj9WaKfiZNtxKWObRRI4NMODfRC9f+9FfASRHGiObxod
         BONg==
X-Gm-Message-State: AOAM531GCdE4M34SCY8R22bg8TqTnK4Ea37WmLtRUcuvPm1VJYDcSDVk
        XZAhacG3HhgFnNCQViMQDC7mCtYwXSo87S1GFc0=
X-Google-Smtp-Source: ABdhPJz/8Ek/3x9uym5HDbnJD4Mt8KqQf2CayEK1/NYDyMkc9ARLump2dvB3zT7oIXSPcWrN47pcccgNs4v2KczTCIQ=
X-Received: by 2002:ad4:576b:: with SMTP id r11mr6495521qvx.34.1644753176669;
 Sun, 13 Feb 2022 03:52:56 -0800 (PST)
MIME-Version: 1.0
References: <20220213213935.2c5ef8c2@canb.auug.org.au>
In-Reply-To: <20220213213935.2c5ef8c2@canb.auug.org.au>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sun, 13 Feb 2022 12:52:45 +0100
Message-ID: <CAOX2RU5NzOK+d-QEMsOiSPX85M2_B44SeJUteZepsyZny7fgnQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the qcom tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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

On Sun, 13 Feb 2022 at 11:39, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   bf8f5182b8f5 ("clk: qcom: ipq8074: fix PCI-E clock oops")
>
> Fixes tag
>
>   Fixes: f0cfcf1a ("clk: qcom: ipq8074: Add missing clocks for pcie")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     Can be fixed for the future by setting core.abbrev to 12 (or more)
>     or (for git v2.11 or later) just making sure it is not set (or set to
>     "auto").

Hi Stephen,

Sorry for the short hash, don't know how this happened.
Do you want me to send a v3 with the fixed hash?

Regards,
Robert
>
> --
> Cheers,
> Stephen Rothwell
