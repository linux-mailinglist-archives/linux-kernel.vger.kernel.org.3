Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44234BFD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiBVPlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiBVPln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:41:43 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1E616306A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:41:16 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id j8-20020a056830014800b005ad00ef6d5dso9940092otp.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdZz965AiNgu7XYs/4JM/gAPu6cnfP8S+NyKdfSJamA=;
        b=RvmmEc32iSHPZu9eb8X2iYgT85hR+2hF5evOwHAo/fKqZntjJCV4DNKhUcui4nWaCu
         fRo0Cn2wefDFuaKSP2QAJa4yNNiKO+v+qqRJ7FWbhWiD8dpZWBGgUu2cQgggNcI+/fQL
         vCGwrwtSMtEaPWFO8jDHpsJNmlutyVL2tzV0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdZz965AiNgu7XYs/4JM/gAPu6cnfP8S+NyKdfSJamA=;
        b=c/SpEeIVztcxFfFe50lkhGTZMIE2ei+ukXAfXtzGaHyFeXWpP1TfcUTdXWbN375goH
         VHmIF35ihRF1vc/astB5tS4hO9S/g5ARehhBAswMuT1PJh8bZiGXA8dvgrHXAGKee2jn
         Rjq+EDCKmErlKCj2Zx6eD0vvLOyMN9YzHsqJzA/N1/SkLddU2tZOFPbPBuBNYU36JtcC
         ZpjpKj89Js1vyl+ZDTiRbXW+JKPJCy8i/p5/cm9SAgpCRmgZBo7qASYaKdUQJXMWYlcE
         su+O5Svc45L+4UADJ4EkR7JkB3uZfSHhTRmGD2Z5W3QhH++JSckI31pAiUPLspZSDaU/
         /Xmw==
X-Gm-Message-State: AOAM531d0naex9ArNxADUVresx0e7HzsuIm2jYu//8yQZ+WrBYCJAmny
        2iJ0pHmWYJxFBJ6ZkZPSQ11TmmGJmGpLBVtSM7HKKA==
X-Google-Smtp-Source: ABdhPJxHw3aHz9EX5MJyYAjDGfUPBOfEI4Z4vQPm++pvEtyZDb7ClulGtzUYIGKbV4vmFn3DAwxvaKCR5942eZ9b8D4=
X-Received: by 2002:a05:6830:1687:b0:5ad:4b8f:a3bf with SMTP id
 k7-20020a056830168700b005ad4b8fa3bfmr6273162otr.365.1645544475690; Tue, 22
 Feb 2022 07:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20220218200811.17136-1-desmond.yan@broadcom.com> <YhCdNyRxGYmhx21f@kroah.com>
In-Reply-To: <YhCdNyRxGYmhx21f@kroah.com>
From:   "Desmond Yan (APD)" <desmond.yan@broadcom.com>
Date:   Tue, 22 Feb 2022 07:41:04 -0800
Message-ID: <CAEuuh2_b-xGAux_EmBaNCGcBM7C0-Z8d_q1BBZ+LA0zpkZEunQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] misc: bcm-vk: add kconfig for supporting viper chip
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f53b2505d89d2dea"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f53b2505d89d2dea
Content-Type: text/plain; charset="UTF-8"

Greg,

This is to allow the customer to use their own driver, by default,
which is their preferred option.

thx
Des


On Fri, Feb 18, 2022 at 11:33 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 18, 2022 at 12:08:11PM -0800, Desmond Yan wrote:
> > Add kconfig for enabling bcm-vk driver to support the viper chip.
> > Default is off and only explicitly configured that the viper chip
> > would be discovered by the driver and loaded for usage.
> >
> > Tested-by: Desmond Yan <desmond.yan@broadcom.com>
> > Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
> > ---
> >  drivers/misc/bcm-vk/Kconfig      | 10 ++++++++++
> >  drivers/misc/bcm-vk/bcm_vk_dev.c |  2 ++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
> > index 68a972772b99..43910a378163 100644
> > --- a/drivers/misc/bcm-vk/Kconfig
> > +++ b/drivers/misc/bcm-vk/Kconfig
> > @@ -16,6 +16,16 @@ config BCM_VK
> >
> >         If unsure, say N.
> >
> > +config BCM_VK_VIPER
> > +     bool "VK driver for VIPER"
> > +     depends on BCM_VK
> > +     help
> > +       Turn on to enable using the vk driver for the viper variant.
> > +       Used for development environments where viper uses VK driver
> > +       and VK firmware rather than an alternate firmware and driver.
> > +
> > +       If unsure, say N.
> > +
> >  config BCM_VK_TTY
> >       bool "Enable tty ports on a Broadcom VK Accelerator device"
> >       depends on TTY
> > diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
> > index ad639ee85b2a..41dbfa4fa4a5 100644
> > --- a/drivers/misc/bcm-vk/bcm_vk_dev.c
> > +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
> > @@ -1633,7 +1633,9 @@ static void bcm_vk_shutdown(struct pci_dev *pdev)
> >
> >  static const struct pci_device_id bcm_vk_ids[] = {
> >       { PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VALKYRIE), },
> > +#if defined(CONFIG_BCM_VK_VIPER)
> >       { PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VIPER), },
> > +#endif
>
> Why do you need a new config option just to add a new device id?  Why
> would you ever NOT want this option enabled as there is no other driver
> for this hardware?
>
> thanks,
>
> greg k-h

--000000000000f53b2505d89d2dea
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Y3hUv4qpgBHMYL0QOV49hRCEPA9bdA1E2tJZaPTCgQjIBKTXbV/VA5CMlMe/UjOH6nY1hID+c33O
JjJlS0Q6uDUPv4Xi6hhq1owIm8lcawNZMHODVk3RAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGRlc21vbmQueWFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUR/AZEnas6F5UTEkX9MSLkmoVu0kw
DQYJKoZIhvcNAQELBQADggEBACgclyA89UFYSNYkHRyDaRI1Yfn2L/TiNQDFtP5Jd+W/g9Ouqvq9
uHw8dCd2QCw8piC0g25U7Q/Tcnfu6sydKZBdtTvv1ZlyCFajkHgSVjZJHmdGAPZdfArtBTlLdYux
VHvqzlQUuX8vTR7zwapU7Q4S3e/wvJljm0qFlEm9iM7c7X6Qev+iYW+cH0a7StliJYAboI8wTeU5
+CRFe63jlAmMwVJgocvWVCzzG9rP+qiMxBVkmg+la+oG0UHXw4aTu+JfvXadtGCFgsfNrJ8Z5do0
X8qLr2r16JY0XDTgGVsdivp1TA9Rgv+1dAof3Hu3oabaRfztJlUXP4A1TylsLVsxggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxu8RiVGamNIPMsivswDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHG3VHXIbcRj+7MevLTvJL/QL86OfwLP+hHp
AkabXN/lMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDIyMjE1
NDExNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQCX5UbXs7N1q1SzE7F7E1QwAcerbl9A6S3YxXD9F94QfBNEzUvM9KEp
j0dZFMzGM3EXGB3E5zR5icoxBG5y6jneTSKPItHSgmExw89ENrsYXYJblgTO3oWDLDdDYTcfBpjS
0h7Yj2tpckbJ20Q3WTxhWfXkNUZx/9FpjrskeAwkqPY3Kuqdt/Iqmn6IweAUB1Fj+Rhr8Nyxq9+8
PpTdOGPJ/qcR8DNDpLNtXqcBYz9FhWh1gTabmUMg06I8Hz0gmXWUqQPaBhs6+GLTDnCp2NyPGxCn
0Tq45KGd1mxQ2/w8dAYMblmD5oAh6qAT3AFHo5MVAR6oIYW9mLhGGSqpKaRg
--000000000000f53b2505d89d2dea--
