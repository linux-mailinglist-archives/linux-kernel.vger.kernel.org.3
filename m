Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECC74C3CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiBYEPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiBYEPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:15:13 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102522465FF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:14:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s13so2581366wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJf/F2E1nKyOjmfnE0Kz9XwI++hQJgC60yfa6VV44Tk=;
        b=SCNgjvyUqQqPy5/1OXOHt6z3InKBEz9ohbIfPu9+F11ZLk+3FRWSYhxJBsgyqIzeVM
         Q+z+OR/rb13pYHsusekVpTxYBT0//auMbQtTpK1r08xt6aO3oR6DFPee7Xpo23Fh0jVD
         hXV11kqvp7XL0didkzWm+Tx1WHgU9zmpbDF1fJrifidD0PWGL0t2xKoMNW4Vpx363D/Y
         FGe/6Bokvc2vLxo4u++A6KN+LbJ87Ti/hRJJJCHgiWrBXy3yMylXfvjtF88VEe2diPan
         ISIHIMAK2iygZY6UxM8504D9I0yIUtDcIiPTVggmVbB2L/rJKX9UzpNkWVv3cDeK5xI8
         OS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJf/F2E1nKyOjmfnE0Kz9XwI++hQJgC60yfa6VV44Tk=;
        b=pDQItfyqnfaE7T8907tPCzNLMcOvaixt/n5kIYrQsrMYPL9mfmJi5ui2M2cLbazKRK
         z388WMQ+7BK4aPIqoYgLxBIevRVLHB5IMHgho8RzvAol6aZAFs8rMYkSLZRtbVnuNwJ1
         6iSLLRFi6ZXUSzyhO9iffNg/+OGa2kvtaeni0OhPbBNQg5Q16m06wR1sRSMkAmaZaG1U
         qchm/GghPPqXrKSpK7BezGeTUHLc8gGMJgzoaG/rOKoY1hKragMcxN+VzjVPlXNta+lW
         FBYLrdHkc0kbdJzlrTiJqhM54/Kn1KdageFhxUlHuMxLnwtcivPJY5GSDPJiawZIytu1
         GaTg==
X-Gm-Message-State: AOAM532NXI2X0BS+U1rQiyIYbvcYcIlhLDXjRrQq68g7LdzalV6+y/NC
        WPMwlyUGxnAcjCCVwSHtFyHxSIaHq105qzuA4+hZeg==
X-Google-Smtp-Source: ABdhPJyOKnj9JiRXrsuEw3Jgm8tIx3MxkdbHICx139eeiQEkY4JydNdAheDnh2cTBawJuXAeCE5IAWlHNEo9TpLEp5w=
X-Received: by 2002:a5d:5446:0:b0:1ed:c29c:1a4d with SMTP id
 w6-20020a5d5446000000b001edc29c1a4dmr4532405wrv.46.1645762479438; Thu, 24 Feb
 2022 20:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20220224035902.1594253-1-davidgow@google.com> <20220225005304.140FFC340E9@smtp.kernel.org>
In-Reply-To: <20220225005304.140FFC340E9@smtp.kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Feb 2022 12:14:28 +0800
Message-ID: <CABVgOSku_a7=w-AWcW0fa1jdk2qP923+oYq85s1zhKEaBrThgw@mail.gmail.com>
Subject: Re: [PATCH] clk: lan966x: Depend on CONFIG_IOMEM
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fe960c05d8cfefea"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000fe960c05d8cfefea
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 25, 2022 at 8:53 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting David Gow (2022-02-23 19:59:02)
> > The lan966x clk driver depends on IOMEM functions, in particular
> > devm_platform_ioremap_resource(), but doesn't state a formal dependency
> > on it in Kconfig.
> >
> > Add such a dependency, which prevents this driver from being enabled
> > on UML configurations without IOMEM.
> >
> > This fixes the following build failure:
> >
> > /usr/bin/ld: drivers/clk/clk-lan966x.o: in function `lan966x_clk_probe':
> > clk-lan966x.c:(.text+0x294): undefined reference to `devm_platform_ioremap_resource'
> > /usr/bin/ld: clk-lan966x.c:(.text+0x3aa): undefined reference to `devm_ioremap_resource'
> > collect2: error: ld returned 1 exit status
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >  drivers/clk/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 3cdf33470a75..7b5db8a9eb4f 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -231,6 +231,7 @@ config COMMON_CLK_GEMINI
> >
> >  config COMMON_CLK_LAN966X
> >         bool "Generic Clock Controller driver for LAN966X SoC"
> > +       depends on IOMEM
>
> What is CONFIG_IOMEM? This is superseded by
> https://lore.kernel.org/r/20220219141536.460812-1-horatiu.vultur@microchip.com
>

Whoops, thanks! If I had a nickel every time I forgot the "HAS" in
"CONFIG_HAS_IOMEM"...

This patch indeed is no-longer needed in clk-fixes, so let's abandon it here.

Cheers,
-- David


> >         help
> >           This driver provides support for Generic Clock Controller(GCK) on
> >           LAN966X SoC. GCK generates and supplies clock to various peripherals

--000000000000fe960c05d8cfefea
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCc
8m6Md3NUghCo/5KQMZikd/Q3OdbUpmNGqXEIcVQztTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMjUwNDE0MzlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEANaZ8ulie59tTpHMd1TQF
C62PJikiWUSm9jhl0ejWcpzGGEdN2ARXWW6+O1xYf1uAGH1Pzy9xBIIFYzV+t5jVJI/rEjj+mWS5
U2i/Msef/w1NKKIuCci4Tam+A1AHV1KHadegQ/YPXsXR6PMvfXzaeXiRXeyeLaMv/SM7e9mVwjpY
tl1M6OaeI8b1lNegQHUP0AiAHYKnb7P+x0Zbp+sF7vffzOEUQzk/R4y7yPqEmZANEgEeoUzPK5nG
nKaL5CevL46gm7VZh41uRr9mkKyxkZOAihgG50SpqXtAVOiXkZlf50oR+4jV6KKUypGNMLppOWzW
iKHqdyMueuNSrLG1Fg==
--000000000000fe960c05d8cfefea--
