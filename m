Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2058E4BC0FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 21:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiBRUJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 15:09:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiBRUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 15:09:18 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE7324B2A5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:09:00 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d27so16328553wrc.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KK4LIfRjQ7XdJ65sijjMTA8KL2jena4OMb/vo+SZgDA=;
        b=O4lADO++B26IWMN04OttFj1+9ZaHx1e8RuhuGH3Z0GIc9ZqRqR01W6LYQfqUvFIBK9
         unVe+v8x2ugV8R88ZNSqd2yntgbwm8NfRHFoovqACbIAmJiYAdp/d/YSXVde1vGEqeHj
         BkJttgPyNSwWbdFFNx5z0VWbIRrite7ZeFVqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KK4LIfRjQ7XdJ65sijjMTA8KL2jena4OMb/vo+SZgDA=;
        b=WImId9w9XIy81aX3WvqiD8+Hx3fC92ubDH/Z12RRL5XZMrnkeDVUqC0e1pQ9H/2zrK
         hpgKepW/jCDM7oLNSapFLJOJyFiMBYt2HXJetLU1WCW3IBjVCh+kJfa0DIcwXOc2cJFi
         UBMmx9Lprat/xHw9vChIgUp/sH1xZ5VXwj+m6TdeXzsXlqzni0SJd1tbCZ3GTsRwzoDw
         xMOdWhYzgAUiDiwZsHPzUOojCjDAHHNMuXZDx/RZcTAgV5gF8sN7SEVMYy0q32FTwvxo
         OU8EPmSpOv6PZwMIKzEomvrX2D2QMITrkWAd6xMAUP/sq2wkFfRpl22qTAHmPTHl6Tmd
         /Zdw==
X-Gm-Message-State: AOAM5331XAkAq+ERYEOuMVDcV1gZaO4aJoJgpnkFbwPKmuP+KnvlDiHZ
        mPLRX1oODhFAofpdXh6DQ60FUQ==
X-Google-Smtp-Source: ABdhPJw6U7Nqb50Dj2I+lZOKNtWXDcg5O5UVOnx7P0rw6O19tARBHzQMAjTAaQPIa71MtF//2rybsg==
X-Received: by 2002:a5d:47ce:0:b0:1e8:88b7:446a with SMTP id o14-20020a5d47ce000000b001e888b7446amr7305907wrc.459.1645214938824;
        Fri, 18 Feb 2022 12:08:58 -0800 (PST)
Received: from dy890235-Precision-Tower-3620.ric.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id g8sm32904815wrd.9.2022.02.18.12.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 12:08:57 -0800 (PST)
From:   Desmond Yan <desmond.yan@broadcom.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v1 1/1] misc: bcm-vk: add kconfig for supporting viper chip
Date:   Fri, 18 Feb 2022 12:08:11 -0800
Message-Id: <20220218200811.17136-1-desmond.yan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000007c8bc05d850747f"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,MIME_NO_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000007c8bc05d850747f

Add kconfig for enabling bcm-vk driver to support the viper chip.
Default is off and only explicitly configured that the viper chip
would be discovered by the driver and loaded for usage.

Tested-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
---
 drivers/misc/bcm-vk/Kconfig      | 10 ++++++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
index 68a972772b99..43910a378163 100644
--- a/drivers/misc/bcm-vk/Kconfig
+++ b/drivers/misc/bcm-vk/Kconfig
@@ -16,6 +16,16 @@ config BCM_VK
 
 	  If unsure, say N.
 
+config BCM_VK_VIPER
+	bool "VK driver for VIPER"
+	depends on BCM_VK
+	help
+	  Turn on to enable using the vk driver for the viper variant.
+	  Used for development environments where viper uses VK driver
+	  and VK firmware rather than an alternate firmware and driver.
+
+	  If unsure, say N.
+
 config BCM_VK_TTY
 	bool "Enable tty ports on a Broadcom VK Accelerator device"
 	depends on TTY
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index ad639ee85b2a..41dbfa4fa4a5 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1633,7 +1633,9 @@ static void bcm_vk_shutdown(struct pci_dev *pdev)
 
 static const struct pci_device_id bcm_vk_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VALKYRIE), },
+#if defined(CONFIG_BCM_VK_VIPER)
 	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VIPER), },
+#endif
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, bcm_vk_ids);
-- 
2.17.1


--00000000000007c8bc05d850747f
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
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPpzbcYnZZQVEYGljIWExgxwsFO5uOL7s59s
tovZbwZeMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDIxODIw
MDg1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQB89kumZ1woZfJU0wDuDZEs4m+pm1B76NmuNj5OwG9dx5MMeMf81zol
enYvbEye/MgymT4v199S3cADfHu+KxacczbZQnB3uiYu0ZpjpaRBwFPU9pUVcZs08glMP39S4wLm
hXzpI3AQ9mquLfM889ih12J9DHqmsN+6JsanEx8cqiiuyyBrhpaVI2OkLVV8mk3PjjOYciELlGKB
ITktfqBPhAXN0NKpCWKrSPTUe9DY9w5d70/1MuD1kehQ4ne9AdvI4IkLyirDPysfmcEHhLI9rdYO
HzO5Mf/bDC4ieaI0QdKzHw0Off6jlUWR+tVjriJyXJIq9ryeBxjgDoGlbZWl
--00000000000007c8bc05d850747f--
