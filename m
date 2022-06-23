Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFF05579FF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiFWMIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFWMId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:08:33 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860BB4B1E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:08:32 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y77so681098oia.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gyZqQXrE1oAKL67wT+hGw2Pl78mZ0Dy0a81L+pVfTtc=;
        b=DKgz1RggJTNYg8Dh1902smt3bH0UGIFYKcHYFKRGkzuvs80CrNqI5yZb3+GylkCtk7
         dlAUgmGrhFVkrHTPD4wPXdSysV+wzxK0FrBgQ6/REZPbGECiqQMMEh9FbYNVQON1sZzD
         snu6YRfeac+U0ym+SP2G60Y2YATG3QCnCD2qRT0wtKyx4FGBeg4WJZk6wi3pcBHe0ZXW
         XiVRyLeAey5VlrvW/TuN4EJQFxwUs+ovERwxxgQW7CX3HW5rETYckCc8OS6F3bntNjav
         DogQrTRKAPV4MoGoX0LfYapMV4KahxUv7fLtFBxMlD4ShX7w8q2ruNWs+q5SBE80yOKP
         5Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gyZqQXrE1oAKL67wT+hGw2Pl78mZ0Dy0a81L+pVfTtc=;
        b=KF0BHe+BnAz+YGgqDysdoiJI5joiRfUDHef9oNSviGocZz4kOccepSs/48U9/dqDkN
         kAoc660HKuDTVbjI+sZitJMWktMHSNQ6/VC40Ob99dWxfgq9xVM5INzxPD1NUbRNg7BW
         pQpbk0nwWhvSSbKmS61dYc+mpFsEwKP4bsRVmolKq88LtleQ5R3/FOtwk9JD/RZ7wfCc
         kWK/O5ZwrgrIRXhuj5VHp95ZY34rx/i/CeCl0UjmGXd5LcBy75DiDjVnQ0FwZV/QyG+s
         CEmShYSSs6Bb+sxoz3X328iq8kUsYtBgIppVKRwsVcG1yjB6j4PrQjSnATmTPBYRyE9q
         jisg==
X-Gm-Message-State: AJIora+3ikbgFcOAwWoxpmmYUrrtmkZ8zv2Y8OKvW+wamFpKgOfBJYFv
        QZUR+Vlef3tOb0JUtXJubgyzjbZKtx373aJIWpMBvg==
X-Google-Smtp-Source: AGRyM1sN1Kc805BDBrcC6gBTpk9T04QLNUFNK7mehzsjqN7Ui2L8ULNfuMmkwDLeKdm60BdDNLtwxJcA5CpCTlqmXQA=
X-Received: by 2002:a05:6808:120a:b0:333:54f1:351 with SMTP id
 a10-20020a056808120a00b0033354f10351mr2055076oil.70.1655986111699; Thu, 23
 Jun 2022 05:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220619104712.125364-1-renzhijie2@huawei.com>
In-Reply-To: <20220619104712.125364-1-renzhijie2@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Jun 2022 14:07:54 +0200
Message-ID: <CAPDyKFp7+wwdUO6=0fqMHeNKsZ5LQqk4fC4RMwrir4g6R+pTpQ@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-pci-gli: Fix build error unused-function
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     adrian.hunter@intel.com, reniuschengl@gmail.com,
        jasonlai.genesyslogic@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2022 at 12:48, Ren Zhijie <renzhijie2@huawei.com> wrote:
>
> If CONFIG_PM is not set.
>
> make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu-, will be failed, lik=
e this:
>
> drivers/mmc/host/sdhci-pci-gli.c:834:13: error: =E2=80=98gl9763e_set_low_=
power_negotiation=E2=80=99 defined but not used [-Werror=3Dunused-function]
>  static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slo=
t, bool enable)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [drivers/mmc/host/sdhci-pci-gli.o] Error 1
>
> To fix building warning, wrap all related code with CONFIG_PM.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 78fe993ae714("mmc: host: Improve I/O read/write performance for GL=
9763E")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 50 ++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index a76506adc206..4d509f656188 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -831,31 +831,6 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *=
mmc)
>         sdhci_dumpregs(mmc_priv(mmc));
>  }
>
> -static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slo=
t, bool enable)
> -{
> -       struct pci_dev *pdev =3D slot->chip->pdev;
> -       u32 value;
> -
> -       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> -       value &=3D ~GLI_9763E_VHS_REV;
> -       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> -       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> -
> -       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> -
> -       if (enable)
> -               value &=3D ~GLI_9763E_CFG_LPSN_DIS;
> -       else
> -               value |=3D GLI_9763E_CFG_LPSN_DIS;
> -
> -       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> -
> -       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> -       value &=3D ~GLI_9763E_VHS_REV;
> -       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> -       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> -}
> -
>  static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
>  {
>         struct cqhci_host *cq_host =3D mmc->cqe_private;
> @@ -991,6 +966,31 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *s=
lot)
>  }
>
>  #ifdef CONFIG_PM
> +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slo=
t, bool enable)
> +{
> +       struct pci_dev *pdev =3D slot->chip->pdev;
> +       u32 value;
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +       value &=3D ~GLI_9763E_VHS_REV;
> +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> +
> +       if (enable)
> +               value &=3D ~GLI_9763E_CFG_LPSN_DIS;
> +       else
> +               value |=3D GLI_9763E_CFG_LPSN_DIS;
> +
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +       value &=3D ~GLI_9763E_VHS_REV;
> +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +}
> +
>  static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
>  {
>         struct sdhci_pci_slot *slot =3D chip->slots[0];
> --
> 2.17.1
>
