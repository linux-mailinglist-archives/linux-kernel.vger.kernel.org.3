Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB654D18E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345912AbiFOT0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345719AbiFOT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:26:23 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3508846651
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:26:22 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id t1so22272985ybd.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7ap878U9WJiqZiLJtB8+WDoIVBGF2CyyeANmhqBwmc=;
        b=KtA+QsE4mywVenk5Gy1ER0/poJuM4+WHV2wmlEIamfsUNz3E2CsoWt3w0Iyctc7xJZ
         x7KBpuIuC1qg7FsAwX7Vhwx6S5DExH4A8OQn4MVmzx5fD4HUKu+tt/AYxmc1pYXf0dHo
         F+kMNtE3HrY3F+iYbkNSP6exnXcLXMXDKgqkk5X44eFrGHqgney3cPXC6Ax9vnHi756j
         t+E076K7D4yVrNA155k1K3Ke/v7Mb90yeD3jbz0rGTDAFDZZwJxmRjCY5TbEoYqU5UKe
         RLt4TRmayzVNLcEll4soeaPO2Y7Iqy7HMbxYAdBL5sawr/b4CEjnlsjf43KZcI0Pukyb
         Yg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7ap878U9WJiqZiLJtB8+WDoIVBGF2CyyeANmhqBwmc=;
        b=c9p84IWoJfCS474p+QL75pjzl3EbK+aQlqFexRuvbx4o939QXuREa1P0abFkgco/AH
         bxaX7nHpO34PIJ5Qt4BK2zONjwxf3StiJMsbgfX0oa8TnRKvzSyCYa4FObuUmNdfMazF
         KYZoKn0l+OGcii1hiKE4fyk036Ee2H8vCWNqwvBpeICF3YbvYhyG4Wr7B9ENLyX0y0bJ
         tfUgmpZdssFN9sSvhRZPIjX8bYhumOcIoeq+K4oDpnnkfSLSR+33L1sHHmfQsaJkqwAD
         5YY1/afl9y+VRk0qrcvWbHE/F9fz8Gl+LPUbeWOxzjiT0WpXpEYyno2+arqax0DlDFKJ
         1W0Q==
X-Gm-Message-State: AJIora9Ogw31d+NPvo3/yZlfSqsMr68B8SnXR+f3+itz9/Scp8NR2LT1
        gAvruuOwFJaWf7o4HvXV/IFmjnvT9Q60jY94lnTH4w==
X-Google-Smtp-Source: AGRyM1tvrcUsHTOVHdrJSj+Bv5J/r8X/AQcZj0tTScEAnnW9cIKrg6CY2Nf/BMod6r2Ss+T6SGurUcC9KPzrigBne9Q=
X-Received: by 2002:a25:b51:0:b0:663:4ff1:d20d with SMTP id
 78-20020a250b51000000b006634ff1d20dmr1499507ybl.608.1655321181295; Wed, 15
 Jun 2022 12:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsP05V+bVoZsPto-ZdZra3Mo4unBjNqyk1dOjfMEK1XWg@mail.gmail.com>
 <20220615052503.6dvtnuq2ai45pmro@vireshk-i7>
In-Reply-To: <20220615052503.6dvtnuq2ai45pmro@vireshk-i7>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Jun 2022 00:56:10 +0530
Message-ID: <CA+G9fYvifz5xDDNjoJBt2MRfdqwDtNf53teWXUs5QCOn2uhbfw@mail.gmail.com>
Subject: Re: [next] arm64: db410c: WARNING: CPU: 0 PID: 1 at
 drivers/opp/core.c:2265 dev_pm_opp_clear_config+0x174/0x17c
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Wed, 15 Jun 2022 at 10:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 15-06-22, 02:49, Naresh Kamboju wrote:
> > Following kernel crash reported while booting arm64 db410c board with
> > Linux next-20220614 [1] kfence enabled on this kernel.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Boot log:
> > ---------
> > [    0.850420] WARNING: CPU: 0 PID: 1 at drivers/opp/core.c:2265
>
> A print like this normally comes when we hit a WARN or something.
>
> Here is the line 2265 from above tag
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/opp/core.c?h=next-20220614#n2265
>
> which doesn't have any such WARNs there. I wonder where exactly we hit the WARN
> here and why it isn't showing up properly.
>
> > dev_pm_opp_clear_config+0x174/0x17c
> > [    0.850447] Modules linked in:
> > [    0.850459] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> > 5.19.0-rc1-next-20220610 #1
> > [    0.850470] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > [    0.850477] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    0.850489] pc : dev_pm_opp_clear_config+0x174/0x17c
> > [    0.850501] lr : dt_cpufreq_probe+0x1e4/0x4a0
> > [    0.850513] sp : ffff80000802bb00
> > [    0.850518] x29: ffff80000802bb00 x28: ffff80000ada1c30 x27: 0000000000000000
> > [    0.850538] x26: 00000000fffffdfb x25: ffff00000311f410 x24: ffff00000389ec90
> > [    0.850557] x23: ffff80000a9eea98 x22: ffff80000a9eed00 x21: ffff80000ada1b68
> > [    0.850576] x20: ffff00000389ec80 x19: ffff00003fc41308 x18: ffffffffffffffff
> > [    0.850595] x17: ffff800009f21700 x16: ffff8000080955c0 x15: ffff0000031c2a1c
> > [    0.850614] x14: 0000000000000001 x13: 0a6b636f6c632064 x12: 6e69662074276e64
> > [    0.850632] x11: 0000000000000040 x10: 0000000000000020 x9 : ffff800009006964
> > [    0.850650] x8 : 0000000000000020 x7 : ffffffffffffffff x6 : 0000000000000000
> > [    0.850668] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > [    0.850686] x2 : 0000000000000004 x1 : 0000000000000000 x0 : 0000000000000000
> > [    0.850704] Call trace:
> > [    0.850708]  dev_pm_opp_clear_config+0x174/0x17c
> > [    0.850722]  platform_probe+0x74/0xf0
>
> Nevertheless, I see one place from where such a WARN can be hit, which can be
> fixed with:
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 58eae9de4b91..c3d4058d33fc 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2437,7 +2437,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_config);
>   */
>  void dev_pm_opp_clear_config(struct opp_table *opp_table)
>  {
> -       if (WARN_ON(!opp_table))
> +       if (!opp_table)
>                 return;
>
>         _opp_detach_genpd(opp_table);
>
> Not sure it fixes the issue you reported here though.
>
> Can you run the tests for my branch once, it has the updated fix as well.

As per your suggestion, I have tested [1] this tree and branch and it worked.
The reported kernel warning has been fixed.
Thank you.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

>
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> --
> viresh

[1] https://lkft.validation.linaro.org/scheduler/job/5179605

--
Linaro LKFT
https://lkft.linaro.org
