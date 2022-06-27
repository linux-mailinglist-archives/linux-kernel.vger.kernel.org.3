Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6335855C44B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbiF0TGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiF0TGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:06:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9CD2605
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:06:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c13so14393353eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UixlsQbwpD0Az/ygfXPQfJv1CTgXdRlCeH87+E1Jpkk=;
        b=K9NSlK0aHko1CpZqZfpLelydiDN9Ve5ju5wzE+N1P+HUekCx5TA0dm7SU0OF/5vah2
         NpkVlL6dl12ieqisAAfa6D7pZKQGnVDbb5ztjC5h3FXE6To/dtRfI6U74U9VVRGR1eqV
         a+09CgKVDC6LSmjpvcNkWmfzr9bfdqbj/l0zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UixlsQbwpD0Az/ygfXPQfJv1CTgXdRlCeH87+E1Jpkk=;
        b=zE5C8Yrl4dl8P04/vQFAgYJ+PavjQvFP3Yb72+Y+uK/ljgTenfktdVzQQ9iO/84SmR
         YxvC+6/zNVkAfHuLcwiaf8c/Xp+re1OU9aYui6JWXZ6ET9KKYWDCCntKGEPb7jeEDXRA
         gG/L4DM7DifrADgRLP2KBIAQN///e3USifrTO4a2eqPeVzy7OUrD9GmwVjCGCuqKk/2H
         7kG48CM54bHIaWYebBdXu83fMIdAkb+Au8bMIrg/rxonIOVo+/5+e404mGyjvGqb339Y
         1ACMv/XeNWy/+E2b9wkn7bZqoncV+q6h0r5/WmrZr44QIQ2Lq/Ad6h+LGmrEqUPGa28j
         kmFw==
X-Gm-Message-State: AJIora8P/UxLK37PPanrJYjdgDMwnJ7CsbMhpJb/Ik9rkQOBGaZBUd3M
        SPkeNeAc9GOX6sN4hrxsaFhCrU9d5B1TmZckcF/Vpw==
X-Google-Smtp-Source: AGRyM1um1ZYcWlDKxvzcvqbC+EIM7ta9IkhmQUjooME2Xtwl0vZcHyEad+fbI/EsNs/C/PJeKFHSgUTcZ1w0WGR+rRM=
X-Received: by 2002:a05:6402:27cf:b0:435:dae6:26aa with SMTP id
 c15-20020a05640227cf00b00435dae626aamr18292121ede.323.1656356768617; Mon, 27
 Jun 2022 12:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220623145533.2882688-1-cristian.marussi@arm.com>
In-Reply-To: <20220623145533.2882688-1-cristian.marussi@arm.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 27 Jun 2022 15:05:57 -0400
Message-ID: <CA+-6iNx_EW_L5Ffn-L+xyg8VVGVPyBonvBFVV6dq69HpTHdqrQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add SCMI full message tracing
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d3c91405e2729c36"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d3c91405e2729c36
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 23, 2022 at 10:55 AM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Hi,
>
> after a few recent troubles handling too strictly out-of-spec replies from
> SCMI servers deployed in the wild, I though it could have been useful to
> have a basic way to dump at will the effective full payloads of successfuly
> transmitted/received SCMI messages.
>
> The existing SCMI traces already collect a bunch of information about SCMI
> message exchanges but they do NOT keep any payload information: this is
> certainly preferable most of the time since dumping full SCMI messages to
> the trace buffer involves a full copy of the payload.
>
> For this reason I added a new distinct trace_scmi_msg_dump with this series
> in order to be able to selectively enable at will message dumping only when
> required.
>
> Only successfully transmitted and received (valid) xfers are dumped.
>
> At first I was thinking about just dumping raw header and payload, but in
> order to make the log a bit more human readable (without the need of
> tooling to parse the log), I added some parsing/interpretation of the
> header, so that the final result is something like:
>
> root@deb-guest:~# echo 1 > /sys/kernel/debug/tracing/events/scmi/scmi_msg_dump/enable
> root@deb-guest:~# cat /sys/kernel/debug/tracing/trace_pipe
>
> (my annotations non on traces =>>)                       proto  type  cmd   seq  status    payload
>                                                           |      |    |      |     |        |
>  ++ cmd/reply                                             |      |    |      |     |        |
>    cat-224     [002] .....   147.755847: scmi_msg_dump: [0x15]:CMND:[0x06]:[0021]:[0]: 0000000000000000
> <idle>-0       [000] d.h2.   147.758311: scmi_msg_dump: [0x15]:RESP:[0x06]:[0021]:[0]: 25000000000000000000000000000000
>I'll probably still use a script, but
as you are keep
>
>  ++ cmd/reply/delayed
>    cat-223     [001] .....   122.384192: scmi_msg_dump: [0x15]:CMND:[0x06]:[0020]:[0]: 0100000001000000
> <idle>-0       [000] d.h2.   122.405548: scmi_msg_dump: [0x15]:RESP:[0x06]:[0020]:[0]:
> <idle>-0       [000] d.h2.   122.425839: scmi_msg_dump: [0x15]:DLYD:[0x06]:[0020]:[0]: 01000000a05a320000000000efbeaddefecafeca
>
>
>  ++ enable notif/notif
> iio_generic_buf-233     [003] .....   522.399690: scmi_msg_dump: [0x15]:CMND:[0x0A]:[0024]:[0]: 0800000003000000
>          <idle>-0       [000] dNh2.   522.417778: scmi_msg_dump: [0x15]:RESP:[0x0A]:[0024]:[0]: 00000000
>          <idle>-0       [000] d.h2.   522.500945: scmi_msg_dump: [0x15]:NOTI:[0x01]:[0000]:[0]: 000000000800000008daffffffffffff0040d3a45d46fb1610daffffffffffff0040d3a45d46fb1618daffffffffffff0040d3a45d46fb16
>
> Payload is dumped as it comes through byte-by-byte without any endianity
> conversion to avoid further load on the system.
>
> Any thoughs ?

Hi Christian,
I haven't tested this but the format looks good to me.  I have a
couple of minor suggestions
below.

As all numbers are hex, consider dropping the '0x'.  BTW,  the seq
value (eg [0020]) is hex but does not have '0x'.

Some TP_printk()s use this  style:

        scmi_msg_dump: pt=15 t=CMND cmd=06 seq=0021 s=0 pyld=12345678abcdef

which allows one to easily grep, for example, for all non-zero returns

        grep 's=[^0]'

This format is also easy to parse with a script:  strip the preamble,
split on whitespace, and then split on '=' to get the  [key, value]
pairs.

Thanks,
Jim Quinlan
Broadcom STB





>
> Thanks,
> Cristian
>
> Cristian Marussi (2):
>   include: trace: Add SCMI full message tracing
>   firmware: arm_scmi: Use new SCMI full message tracing
>
>  drivers/firmware/arm_scmi/driver.c | 21 ++++++++++++++++++++
>  include/trace/events/scmi.h        | 31 ++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>
> --
> 2.32.0
>

--000000000000d3c91405e2729c36
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
LeylbuEJGL9I80yqq8e6Z+Q6ulLxa6SopzpoysJe/vEVHgp9jPNppZzwKngVd2iDBRqpKlCngIAM
DXgVGyEojXnuEbRs3NlB7wq1kJGlYysrnDug55ncJM8CAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFCeTeUYv84Mo3T1V+OyDdxib
DDLvMA0GCSqGSIb3DQEBCwUAA4IBAQCCqR1PBVtHPvQHuG8bjMFQ94ZB7jmFEGhgfAsFJMaSMLov
qyt8DKr8suCYF4dKGzqalbxo5QU9mmZXdLifqceHdt/Satxb+iGJjBhZg4E0cDds24ofYq+Lbww2
YlIKC2HHxIN+JX2mFpavSXkshR5GT29B9EIJ8hgSjbs61XXeAcrmVIDfYbXQEmGbsnwqxdq+DJpQ
S2kM2wvSlgSWDb6pL7myuKR5lCkQhj7piGSgrVLJRDRrMPw1L4MvnV9DjUFMlGCB40Hm6xqn/jm0
8FCLlWhxve5mj+hgUOPETiKbjhCxJhhAPDdCvDRkZtJlQ8oxUVvXHugG8jm1YqB5AWx7MYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMI+Aj9XRk/wFexb9/
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCcOv0Wvl6UV2j5O7Q6WXDCcO6G6GAa
gwomODY6l7ysuzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjA2
MjcxOTA2MDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAkcEQR3WFR4Q18JvQTGBiwvn2jt102xwvyRuz1t6Us/5xeRCU
b5pAvfxsNLebYzGkO4LsobPXE0snmREhJzl7JfsPqEJQzdDAJ7AjDHre72FSVzvWViYAra6n2alZ
0vr05ahJprw8VV0AUEsFTPTsL6LLeT1xUdltFFHSy2ZDT6rDClEqr1muunEm+LFQLqXvYm7skFmA
5b3Vx9VQUmkxQEMsFJjQRDHBApfq1vlGtHuCJ6JBMXflrDs7tPInq80D5/tu58n88D18XAv7wSWJ
L3uOGNUJHTxql8lulsiPUvyutgt1X1lq6Sl46msw6tzxTndqookJRCsNaqeTyfPh8Q==
--000000000000d3c91405e2729c36--
