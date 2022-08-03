Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF6589298
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 21:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbiHCTJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 15:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiHCTJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:09:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865035A897
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:09:48 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w7so17253743ply.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=TkwGOJawx/Yr2Ae2Exxf1SRzl1c/j4HsmR48lNJCQTo=;
        b=PDwwxyuASMGLUHrfGbUO6MivORx8oq/nHNRjuZc1y6mYXXREKL+Qa43h32XbGBb/K8
         81VZLGnupJPUdgC1CKkD6j+/7txp6G/2MHi9EXKooGtKdUmeWEVrCFy6yUCG138ZPjGW
         lvvXpV2EaUjbCqRX/PYsPXv5fSOWbSTS2PqyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=TkwGOJawx/Yr2Ae2Exxf1SRzl1c/j4HsmR48lNJCQTo=;
        b=RHtkcQlH/hCjwy7dDiCfxL9CjHG73QssPQEN446EC7PRdZg+kaANazP3Q0xL7oSOiK
         Gum1bpJwBDb7so/ilkleU1nZ1K3+uN28ZmIpiHQQAtp3G6jeKME/XzSzIl/MT0DC0dGa
         hWl9YmNxJ7Ufm5GElDZAKs3ll6KwDAk7ukmzB5ptFoVy1iLRaDAowzrbSW2T11uDfii/
         D+Ne3SMRRewf0iGsVMCEBqrBdz9XTi8vi8I92UKxAFO8byqwQMXBfuobWwx8FhqfBBd5
         opBgVvnAA8UcwO+E45mh3Em5l6G7inSwEgcwXieIKyp50ohDQdlsWdBT73/4y2MZgR/N
         262A==
X-Gm-Message-State: ACgBeo05NPzrJiQZSEtcy6qDxpuu7Gs2XDghLn4/TpqRcVcq9p2RuitB
        hvNRNbZMpymvy9w/rY/S/Sm2o12nJGojF/Hv
X-Google-Smtp-Source: AA6agR5PvUYwUL63ql5j0ouIVbEnruh7s/AVGOcNpkTz2+4teCD2oR5ei/C/ZtNVsPm7GfT7Io9ZDg==
X-Received: by 2002:a17:902:e849:b0:16e:81c6:2cb7 with SMTP id t9-20020a170902e84900b0016e81c62cb7mr25305325plg.110.1659553787851;
        Wed, 03 Aug 2022 12:09:47 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id y62-20020a626441000000b0052d40c4c06esm8338163pfb.39.2022.08.03.12.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 12:09:46 -0700 (PDT)
Message-ID: <612446a2-5a22-a349-35fc-47f34792b504@broadcom.com>
Date:   Wed, 3 Aug 2022 12:09:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] misc: bcm_vk: Remove usage of deprecated functions
To:     Breno Leitao <leitao@leitao.org>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     leit@fb.com, linux-kernel@vger.kernel.org,
        Breno Leitao <leitao@debian.org>
References: <20220727111435.2153813-1-leitao@leitao.org>
From:   Scott Branden <scott.branden@broadcom.com>
In-Reply-To: <20220727111435.2153813-1-leitao@leitao.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000009389105e55afa0a"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000009389105e55afa0a
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Unsure, you may need to add Greg K-H to the to email for him to see this 
patch as he picks up misc drivers in his tree.

On 2022-07-27 04:14, Breno Leitao wrote:
> From: Breno Leitao <leitao@debian.org>
> 
> ida_simple_get() and ida_simple_remove() functions are deprecated now.
> These functions were replaced by ida_alloc() and ida_free()
> respectively. This patch modernizes the bcm_vk driver to use the
> replacement functions.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/misc/bcm-vk/bcm_vk_dev.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
> index a16b99bdaa13..a3a82ebbc699 100644
> --- a/drivers/misc/bcm-vk/bcm_vk_dev.c
> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
> @@ -1401,7 +1401,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		bcm_vk_tty_set_irq_enabled(vk, i);
>   	}
>   
> -	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&bcm_vk_ida, GFP_KERNEL);
>   	if (id < 0) {
>   		err = id;
>   		dev_err(dev, "unable to get id\n");
> @@ -1500,7 +1500,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	misc_device->name = NULL;
>   
>   err_ida_remove:
> -	ida_simple_remove(&bcm_vk_ida, id);
> +	ida_free(&bcm_vk_ida, id);
>   
>   err_irq:
>   	for (i = 0; i < vk->num_irqs; i++)
> @@ -1573,7 +1573,7 @@ static void bcm_vk_remove(struct pci_dev *pdev)
>   	if (misc_device->name) {
>   		misc_deregister(misc_device);
>   		kfree(misc_device->name);
> -		ida_simple_remove(&bcm_vk_ida, vk->devid);
> +		ida_free(&bcm_vk_ida, vk->devid);
>   	}
>   	for (i = 0; i < vk->num_irqs; i++)
>   		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), vk);

--00000000000009389105e55afa0a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
cRe0CRXA7ypOJSgxO/nOOyQoaJxT7CGg1npOeSpPjEuc3fE4xum3l0nvU85hj6MlKZu43hokdBh0
D0nLyyhEwlR3AC/msdff/UGbM/JR9vk812RP4m/aNWZFJwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUOhjEpl04Sz9dh5MI82E1
V39lM/owDQYJKoZIhvcNAQELBQADggEBAA7Rlypx/esz/iq1yA4+KW7uwV/aBY344BWcXt6I+SNK
VwFBgFWfLj5vaEud9TVv2fPSiaHJo0umemOJk+43QD+bsoqmgcFXd21PrOt7Jjs+jjVED9VC5kJq
S4NNKUkS+BqijJwSegtVygrc/atrIlJbjI21q4qpemUo5fgwqCNm++BmBGTI8yA09vtGSNDRN42k
lLX9hl3iEj5SBgkQqCbbnoE+ZjjKfqt7ED166WhgyQWNrl39yLcvLj+JRUB3RuvXKZjH0NQEEBII
wZBDSkyneykLt3CBNIhSCTxKM6OWxVp936ALSa5K9FNy00TeWSpokR6NmzaW8VD/EjTgvqAxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx9oXSJpKniO4dS
Gk8wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHpdqnY77CiGftbGsefugAeElvw7
pQP26/jH2JS26uOiMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDgwMzE5MDk0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQB54C3oIHxMWAQMu7EakCVH3VR3QDDmqpJ6uXPFRWHhOygh
8pTwofHdigfMNRMlE/RS0cK8tFmJ0wTKIjIULdBAMNLxhdFfa63/yC4AMbFSSRugjjxKxUSUp2gS
gf0e/4s7ufVlkf2U6zJKQboLgp/8AoFZsFah8DcP2XyPp+4GluZ8mjd2FweLKt9zkuGSkNpNU1Xy
rZvAvYIZj+LPLXjl5GPAyaclOPdnwHdavIoiLCQ8cont/gPoIJL9Ai4zgh95Wn4TxigLiRaMDTY1
zfxw7EonK6AnLyjY17W8K/Or7w+golCa2Wt2FV0txLG4J+waQ/htTWakbB8KFPH8tGkk
--00000000000009389105e55afa0a--
