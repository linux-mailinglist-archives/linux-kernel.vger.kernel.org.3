Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7DC47D0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244620AbhLVLU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhLVLU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:20:57 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0D2C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:20:56 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id r139so1047318qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=tAQUbXepy/D1OV3Qgjbf5t9Ys4GHvjg64wkH4yq2t5k=;
        b=eFSbkYm68RCOyvPXnfa5W4mt765AkhBeFwU2b0mr6jDUVWbXWXR6ZsdioHut0aN6lb
         n39HzWiMfQ5pjQ5hTdFbnrhF7H/RIPbIgMkI4dmiYAeEH6MlJmVISTw+Nm5nN3pbhUC3
         HOBmifOsU8qOZkPy3mghqPO6DJNg9mPA15LdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=tAQUbXepy/D1OV3Qgjbf5t9Ys4GHvjg64wkH4yq2t5k=;
        b=gttsOw34QKcmLztOiiXaL/2OVh4ayThEYmIMxWJ62Uz4hJVe5rBQ+atn0AI2GuS7A/
         NzIIn/C250pgmBTw4jR3xnl34DWo69WtK561HmTznHjUuiJx1tBiS2ENr2dALhcRuPFD
         IAXyCNtIa9cYewN32bBH1nqe6XZaNAAE9sBIuLaMJvi9XYp092JtvHunnj0eMzENjXO+
         /9sZzUT2y0AnCmqV617UIGmWQS6z+bdbSGEaHGQrKTiZ/PQp1MumvoWrrpJ9s/eYz4lc
         uj/3hTfIAuSl1Wk2X1Kr+pK7BYHL2F9W1KCqTF/4CSq23useZt8vOtAE3HLiVKNN2oYL
         DFNQ==
X-Gm-Message-State: AOAM532jIUc7zmS0+j2L5djfUK79IIgo6PfPS5q8wFvssoCHCJuEu5sc
        j/nwoLka5IPFxXlZiaBPxOgT2d9qMliwwC7GnEhQvQ==
X-Google-Smtp-Source: ABdhPJwZPr3NvDHyhMSx40g591bUB3ZGaKhe021bHzk3LLhCbRyS19PqrIuDtzyrU/RpE5dUzHjwKFslc1NMvT4zqeA=
X-Received: by 2002:a37:b182:: with SMTP id a124mr1581809qkf.135.1640172055861;
 Wed, 22 Dec 2021 03:20:55 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20211221123157.14052-1-kashyap.desai@broadcom.com>
 <e9174a89-b3a4-d737-c5a9-ff3969053479@huawei.com> <7028630054e9cd0e8c84670a27c2b164@mail.gmail.com>
 <e7288bcd-cc4d-8f57-a0c8-eadd53732177@huawei.com>
In-Reply-To: <e7288bcd-cc4d-8f57-a0c8-eadd53732177@huawei.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJC+3Le3mXDqGQStbCqvdqjeo0KCwF7x3T9AYMxWSAB1rDXcatBpi8A
Date:   Wed, 22 Dec 2021 16:50:53 +0530
Message-ID: <c26b40bac76ec1bfbab2419aece544ca@mail.gmail.com>
Subject: RE: [PATCH RFT] blk-mq: optimize queue tag busy iter for shared_tags
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c8451c05d3ba5033"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c8451c05d3ba5033
Content-Type: text/plain; charset="UTF-8"

>
> But your change seems effectively the same as in
> https://lore.kernel.org/all/1638794990-137490-4-git-send-email-
> john.garry@huawei.com/,
> which is now merged in Jens' 5.17 queue:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-
> block.git/commit/?h=for-
> 5.17/block&id=fea9f92f1748083cb82049ed503be30c3d3a9b69

John -

Yes, above is the same changes I was looking for. I did very basic mistake.
I applied your above commit while doing megaraid_sas testing.
 While I move to mpi3mr testing, I did not apply your patch set. We can drop
request of this RFT since I tested above series and it serve the same
purpose.

Kashyap

>
> > While doing additional testing for [1], I noticed some performance
> > issue.
> > Along with the performance issue, I noticed CPU lockup as well. Lockup
> > trace -
> >
> > _raw_spin_lock_irqsave+0x42/0x50
> >   blk_mq_find_and_get_req+0x20/0xa0
> >   bt_iter+0x2d/0x80
> >   blk_mq_queue_tag_busy_iter+0x1aa/0x2f0
> >   ? blk_mq_complete_request+0x30/0x30
> >   ? blk_mq_complete_request+0x30/0x30
> >   ? __schedule+0x360/0x850
> >   blk_mq_timeout_work+0x5e/0x120
> >   process_one_work+0x1a8/0x380
> >   worker_thread+0x30/0x380
> >   ? wq_calc_node_cpumask.isra.30+0x100/0x100
> >   kthread+0x167/0x190
> >   ? set_kthread_struct+0x40/0x40
> >   ret_from_fork+0x22/0x30
> >
> > It is a generic performance issue if driver use " shost->host_tagset =
> > 1".
> > In fact, I found that [1] is useful to fix performance issue and
> > provided this additional patch.
> >
> > I changed my setup to have 64 scsi_devices (earlier I just kept 16 or
> > 24 drives, so did not noticed this issue). Performance/cpu lockup
> > issue is not due to [1].
> > More number of scsi device, hardware context per host and high queue
> > depth will increase the chances of lockup and performance drop.
> >
> > Do you think, it is good to have changes in 5.16 + stable ?
> > I don't know if this  patch will create any side effect. Can you
> > review and let me know your feedback. ?
> >
>
> Can you test my merged change again for this scenario?
>
> I will also note that I mentioned previously that
> blk_mq_queue_tag_busy_iter() was not optimum for shared sbitmap, i.e.
> before shared tags, but no one said performance was bad for shared
> sbitmap.
>
> Thanks,
> John

--000000000000c8451c05d3ba5033
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQcAYJKoZIhvcNAQcCoIIQYTCCEF0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3HMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU8wggQ3oAMCAQICDHA7TgNc55htm2viYDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIxMjU2MDJaFw0yMjA5MTUxMTQ1MTZaMIGQ
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDUthc2h5YXAgRGVzYWkxKTAnBgkqhkiG9w0B
CQEWGmthc2h5YXAuZGVzYWlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAzPAzyHBqFL/1u7ttl86wZrWK3vYcqFH+GBe0laKvAGOuEkaHijHa8iH+9GA8FUv1cdWF
WY3c3BGA+omJGYc4eHLEyKowuLRWvjV3MEjGBG7NIVoIaTkH4R+6Xs1P4/9EmUA0WI881B3pTv5W
nHG54/aqGUDSRDyWVhK7TLqJQkkiYKB0kH0GkB/UfmU/pmCaV68w5J6l4vz/TG23hWJmTg1lW5mu
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEjGLIBCiS43TyB41CoVa1lGNYod
igg/tNaYQWjWPEa3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MTIyMjExMjA1NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAO8d3rBpO3TMa5v7K72T5WHutvO0A2mZF5bslUCQbXyN2y
ZGN+u7DAVMrp4LmsuuaRo6nC3W+8z3QXoxYlrKmkQq8c7G0GNA8qr6Bem8GUVbO2uhq4puH2deBe
dBi1n8yEHYbbCaf26W9Xb6CVYg9z/zixWrkqmWTuzNH9MCJZbyfIBamvtjSkbSniqbDrnFvfSfck
qzswAnd/56Cdb1hVy9hv/3Eo2Enj/1y5wovueBeHf+AUxUZ42H25l6x+YdDI6Iqg6H6fpY7Legp6
IA56Jhicur7nF4+a+cYH/IT+fu3gV0tOV5xHnj5VQ1ph2iGyaM4Dyz7iCWI96xnhwzLH
--000000000000c8451c05d3ba5033--
