Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E9C4C9B8B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiCBCyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiCBCyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:54:37 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7AF1C137
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:53:55 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 132so442973pga.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 18:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=W8P0bndC/EUpMARX/RJpbdvGiQxNFSwirs0XwnqDb/A=;
        b=IWFuVIT7r+I1xmMiUz2WomA8BSB+IYTAB4c1uP5AMvzyKIDcwJDt9KVKnu+6vOdhzP
         31rpKZs9+i0xR8pJ5AQdUn+3OYOZQs1dKT6hSoEdkeJociVZ2HE51LagHUrE4ZOwLd0V
         XZjZr6Ux/jlt/Tas5P4KPWK8dPbmHWNH5M5xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W8P0bndC/EUpMARX/RJpbdvGiQxNFSwirs0XwnqDb/A=;
        b=Khr1JHnO2zBaEvd8kMbo1UrPTBe2zk94tv4Qkqq0uuQUIusiA3OwBNSAIakcxMEPlf
         nOLDkXFzMQayRSaz24dsdaOf1mwTbvOxnHciPxrLb0iovafzghxvEq1asyu1aON4uDK6
         ZWmlDmEp5dMPirrUxESLrZ0aTXcMrDyPxZ9B/A7iSqbSY/3hT8iXH5e8vdcbNXyMJGly
         zBzYdsdl5AcfMZ6x1kiGBcA6zPdaRom1OLwBxWBKDPpCG1+anS54GnsPa/HwBmpr/958
         RShMbeP2xrJOFm8CRNwK3QCimCHwYglPvn/Hm76IyMO4kHd9Qh1qQih5gj7wHcn2grYX
         5p4w==
X-Gm-Message-State: AOAM531ZZT/09S+0TX1+WAWsgeCvPUXOjfoEd6SXEK/BYC8j1EJpJDLn
        zRP3+n6SKxiY1H9BJ4D62X3x7Q==
X-Google-Smtp-Source: ABdhPJzvjI0hA7Ac49NR4bDqe7iyUYcn1hrZQCl33vMxeFh6wBIS7lVOoP+x4f7iqyyvP5y37nbIXg==
X-Received: by 2002:a63:9354:0:b0:34d:e4e7:543a with SMTP id w20-20020a639354000000b0034de4e7543amr24321260pgm.48.1646189634923;
        Tue, 01 Mar 2022 18:53:54 -0800 (PST)
Received: from dy890235-Precision-Tower-3620.ric.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id s42-20020a056a0017aa00b004df8133df4asm20117297pfg.179.2022.03.01.18.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 18:53:54 -0800 (PST)
From:   Desmond Yan <desmond.yan@broadcom.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v2 1/1] misc: bcm-vk: Remove viper from device id table
Date:   Tue,  1 Mar 2022 18:53:40 -0800
Message-Id: <20220302025340.25602-1-desmond.yan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000072966e05d933643d"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,MIME_NO_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000072966e05d933643d

As bcm_vk driver is not the production driver for viper, remove
its pci device id from table.

Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
---
Changes since v1:
- remove Kconfig option and simply remove viper pci id completely
---
drivers/misc/bcm-vk/bcm_vk_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index ad639ee85b2a..a16b99bdaa13 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1633,7 +1633,6 @@ static void bcm_vk_shutdown(struct pci_dev *pdev)
 
 static const struct pci_device_id bcm_vk_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VALKYRIE), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VIPER), },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, bcm_vk_ids);
-- 
2.17.1


--00000000000072966e05d933643d
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
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEhhIAoOCtCBjkxQinNOzVBkrh9yx5Dip7UE
WJ8X06ufMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDMwMjAy
NTM1NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQCfgEYkS9A18SBB7ifd+qbww17IjP7okuLUaxCSPc2eAe0oo+w+Gf3M
O9xxVCdBot1n6yNhF+NowrwegHxos1WDRyxZn2Ww16F/tD8QMAOVwUsLAaFJ95sPf0mIQ/QpJiGQ
+pruUjL4KvKqzg8HGBho/WJfCXnm+f3g/B61A0fMJ9prAuFb8RMqKKNV9/QLdZtRA0GLETin4TKl
DVF6V737mJeYOFl3/yeE3QBawBvRSjqg2sOyjcxy6BXbwtzWEazB66A4QryB3qf+ISH/RIHZLrXR
viOFtfECpoeizSlomJhFeccx5Pp/u/ASFLx21YSqL3GpqO4IBiNNVd2OEfjI
--00000000000072966e05d933643d--
