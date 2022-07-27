Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F5F583412
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 22:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiG0U2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 16:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiG0U2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 16:28:30 -0400
Received: from mx2.uni-rostock.de (mx2.uni-rostock.de [139.30.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CF650183
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1658953704; bh=wYujtMIftyArbuldmfvD9P/FF1mhNFu2F0ApzJrZ1sE=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=ed25519-sha256; b=
 X7WYzEps4xiDvZXJD6Dl+WEIxM1rW5a4bbDtidXDvUvTfNN/7BfXnOZDLRvH/gkZncO2bbOV+q+z7iqo3mb6Bg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1658953704; bh=wYujtMIftyArbuldmfvD9P/FF1mhNFu2F0ApzJrZ1sE=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=rsa-sha256; b=
 lcDArlZRl6PG4+eSUFaW84qfHJHaeN0BDlklPoA70GwIub2KidM+be3U+VsLpODwrFhGWCsaBIOdGXoElR/aEZ1to4+gOLRzhsnEe+WNcBXzl/ZEabTs+4vxxz1ry0GQELygOYCiP3EVVXSrDfiixii6+3JPI+Sx35Qttqf4K48=
Received: from 139.30.22.81 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Wed, 27 Jul 2022 20:28:24 GMT
Received: from [192.168.0.222] (91.59.50.48) by email1.uni-rostock.de
 (139.30.22.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 27 Jul
 2022 22:28:23 +0200
Message-ID: <53bdf85f-8c29-7843-7ccd-88432e66b282@uni-rostock.de>
Date:   Wed, 27 Jul 2022 22:28:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] um: read multiple msg from virtio slave request fd
Content-Language: de-DE
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     Johannes Berg <johannes.berg@intel.com>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220607112714.516408-1-benjamin.beichler@uni-rostock.de>
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <20220607112714.516408-1-benjamin.beichler@uni-rostock.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
        micalg=sha-256; boundary="------------ms040807060402020002030106"
X-Originating-IP: [91.59.50.48]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 email1.uni-rostock.de (139.30.22.81)
X-TM-SNTS-SMTP: ECC928D852296DCDFA97C9F7BF7A7AE6329880FA912278F5B755C025201055E62002:8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms040807060402020002030106
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Are there any issues with that patch=3F
I would be happy to receive any comments or an acceptance :-D

Sorry for my former HTML-Email.

kind regards

Benjamin


Am 07.06.2022 um 13:27 schrieb Benjamin Beichler:
> If VHOST=5FUSER=5FPROTOCOL=5FF=5FINBAND=5FNOTIFICATIONS is activated, the us=
er mode
> linux virtio irq handler only read one msg from the corresponding socket.
> This creates issues, when the device emulation creates multiple call
> requests (e.g. for multiple virtqueues), as the socket buffer tend to fill
> up and the call requests are delayed.
>
> This creates a deadlock situation, when the device simulation blocks,
> because of sending a msg and the kernel side blocks because of
> synchronously waiting for an acknowledge of kick request.
>
> Actually inband notifications are meant to be used in combination with the
> time travel protocol, but it is not required, therefore this corner case
> needs to be handled.
>
> Anyways, in general it seems to be more natural to consume always all
> messages from a socket, instead of only a single one.
>
> Fixes: 2cd097ba8c05 ("um: virtio: Implement VHOST=5FUSER=5FPROTOCOL=5FF=5FSL=
AVE=5FREQ")
> Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
> ---
>   arch/um/drivers/virtio=5Fuml.c | 71 +++++++++++++++++++-----------------
>   1 file changed, 37 insertions(+), 34 deletions(-)
>
> diff --git a/arch/um/drivers/virtio=5Fuml.c b/arch/um/drivers/virtio=5Fuml.c
> index 82ff3785bf69..3716c5f6f9aa 100644
> --- a/arch/um/drivers/virtio=5Fuml.c
> +++ b/arch/um/drivers/virtio=5Fuml.c
> @@ -374,45 +374,48 @@ static irqreturn=5Ft vu=5Freq=5Fread=5Fmessage(struct =
virtio=5Fuml=5Fdevice *vu=5Fdev,
>   =09=09u8 extra=5Fpayload[512];
>   =09} msg;
>   =09int rc;
> +=09irqreturn=5Ft irq=5Frc =3D IRQ=5FNONE;
>   
> -=09rc =3D vhost=5Fuser=5Frecv=5Freq(vu=5Fdev, &msg.msg,
> -=09=09=09=09 sizeof(msg.msg.payload) +
> -=09=09=09=09 sizeof(msg.extra=5Fpayload));
> -
> -=09vu=5Fdev->recv=5Frc =3D rc;
> -=09if (rc)
> -=09=09return IRQ=5FNONE;
> -
> -=09switch (msg.msg.header.request) {
> -=09case VHOST=5FUSER=5FSLAVE=5FCONFIG=5FCHANGE=5FMSG:
> -=09=09vu=5Fdev->config=5Fchanged=5Firq =3D true;
> -=09=09response =3D 0;
> -=09=09break;
> -=09case VHOST=5FUSER=5FSLAVE=5FVRING=5FCALL:
> -=09=09virtio=5Fdevice=5Ffor=5Feach=5Fvq((&vu=5Fdev->vdev), vq) {
> -=09=09=09if (vq->index =3D=3D msg.msg.payload.vring=5Fstate.index) {
> -=09=09=09=09response =3D 0;
> -=09=09=09=09vu=5Fdev->vq=5Firq=5Fvq=5Fmap |=3D BIT=5FULL(vq->index);
> -=09=09=09=09break;
> +=09while (1) {
> +=09=09rc =3D vhost=5Fuser=5Frecv=5Freq(vu=5Fdev, &msg.msg,
> +=09=09=09=09=09 sizeof(msg.msg.payload) +
> +=09=09=09=09=09 sizeof(msg.extra=5Fpayload));
> +=09=09if (rc)
> +=09=09=09break;
> +
> +=09=09switch (msg.msg.header.request) {
> +=09=09case VHOST=5FUSER=5FSLAVE=5FCONFIG=5FCHANGE=5FMSG:
> +=09=09=09vu=5Fdev->config=5Fchanged=5Firq =3D true;
> +=09=09=09response =3D 0;
> +=09=09=09break;
> +=09=09case VHOST=5FUSER=5FSLAVE=5FVRING=5FCALL:
> +=09=09=09virtio=5Fdevice=5Ffor=5Feach=5Fvq((&vu=5Fdev->vdev), vq) {
> +=09=09=09=09if (vq->index =3D=3D msg.msg.payload.vring=5Fstate.index) {
> +=09=09=09=09=09response =3D 0;
> +=09=09=09=09=09vu=5Fdev->vq=5Firq=5Fvq=5Fmap |=3D BIT=5FULL(vq->index);
> +=09=09=09=09=09break;
> +=09=09=09=09}
>   =09=09=09}
> +=09=09=09break;
> +=09=09case VHOST=5FUSER=5FSLAVE=5FIOTLB=5FMSG:
> +=09=09=09/* not supported - VIRTIO=5FF=5FACCESS=5FPLATFORM */
> +=09=09case VHOST=5FUSER=5FSLAVE=5FVRING=5FHOST=5FNOTIFIER=5FMSG:
> +=09=09=09/* not supported - VHOST=5FUSER=5FPROTOCOL=5FF=5FHOST=5FNOTIFIER *=
/
> +=09=09default:
> +=09=09=09vu=5Ferr(vu=5Fdev, "unexpected slave request %d\n",
> +=09=09=09       msg.msg.header.request);
>   =09=09}
> -=09=09break;
> -=09case VHOST=5FUSER=5FSLAVE=5FIOTLB=5FMSG:
> -=09=09/* not supported - VIRTIO=5FF=5FACCESS=5FPLATFORM */
> -=09case VHOST=5FUSER=5FSLAVE=5FVRING=5FHOST=5FNOTIFIER=5FMSG:
> -=09=09/* not supported - VHOST=5FUSER=5FPROTOCOL=5FF=5FHOST=5FNOTIFIER */
> -=09default:
> -=09=09vu=5Ferr(vu=5Fdev, "unexpected slave request %d\n",
> -=09=09       msg.msg.header.request);
> -=09}
> -
> -=09if (ev && !vu=5Fdev->suspended)
> -=09=09time=5Ftravel=5Fadd=5Firq=5Fevent(ev);
>   
> -=09if (msg.msg.header.flags & VHOST=5FUSER=5FFLAG=5FNEED=5FREPLY)
> -=09=09vhost=5Fuser=5Freply(vu=5Fdev, &msg.msg, response);
> +=09=09if (ev && !vu=5Fdev->suspended)
> +=09=09=09time=5Ftravel=5Fadd=5Firq=5Fevent(ev);
>   
> -=09return IRQ=5FHANDLED;
> +=09=09if (msg.msg.header.flags & VHOST=5FUSER=5FFLAG=5FNEED=5FREPLY)
> +=09=09=09vhost=5Fuser=5Freply(vu=5Fdev, &msg.msg, response);
> +=09=09irq=5Frc =3D IRQ=5FHANDLED;
> +=09};
> +=09/* mask EAGAIN as we try non-blocking read until socket is empty */
> +=09vu=5Fdev->recv=5Frc =3D (rc =3D=3D -EAGAIN) =3F 0 : rc;
> +=09return irq=5Frc;
>   }
>   
>   static irqreturn=5Ft vu=5Freq=5Finterrupt(int irq, void *data)


-- 
M.Sc. Benjamin Beichler

Universit=C3=A4t Rostock, Fakult=C3=A4t f=C3=BCr Informatik und Elektrotechnik
Institut f=C3=BCr Angewandte Mikroelektronik und Datentechnik

University of Rostock, Department of CS and EE
Institute of Applied Microelectronics and CE

Richard-Wagner-Stra=C3=9Fe 31
18119 Rostock
Deutschland/Germany

phone: +49 (0) 381 498 - 7278
email: Benjamin.Beichler@uni-rostock.de
www: http://www.imd.uni-rostock.de/

--------------ms040807060402020002030106
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EKcwggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWsMIIElKADAgECAgcbY7rQHiw9MA0GCSqGSIb3DQEBCwUAMIGVMQswCQYD
VQQGEwJERTFFMEMGA1UEChM8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hl
biBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLEwdERk4tUEtJMS0wKwYDVQQDEyRE
Rk4tVmVyZWluIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IDIwHhcNMTYwNTI0MTEzODQwWhcN
MzEwMjIyMjM1OTU5WjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ07eRxH3h+Gy8Zp1xCeOdfZojDbchwFfylf
S2jxrRnWTOFrG7ELf6Gr4HuLi9gtzm6IOhDuV+UefwRRNuu6cG1joL6WLkDh0YNMZj0cZGnl
m6Stcq5oOVGHecwX064vXWNxSzl660Knl5BpBb+Q/6RAcL0D57+eGIgfn5mITQ5HjUhfZZkQ
0tkqSe3BuS0dnxLLFdM/fx5ULzquk1enfnjK1UriGuXtQX1TX8izKvWKMKztFwUkP7agCwf9
TRqaA1KgNpzeJIdl5Of6x5ZzJBTN0OgbaJ4YWa52fvfRCng8h0uwN89Tyjo4EPPLR22MZD08
WkVKusqAfLjz56dMTM0CAwEAAaOCAgUwggIBMBIGA1UdEwEB/wQIMAYBAf8CAQEwDgYDVR0P
AQH/BAQDAgEGMCkGA1UdIAQiMCAwDQYLKwYBBAGBrSGCLB4wDwYNKwYBBAGBrSGCLAEBBDAd
BgNVHQ4EFgQUazqYi/nyU4na4K2yMh4JH+iqO3QwHwYDVR0jBBgwFoAUk+PYMiba1fFKpZFK
4OpL4qIMz+EwgY8GA1UdHwSBhzCBhDBAoD6gPIY6aHR0cDovL2NkcDEucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDBAoD6gPIY6aHR0cDovL2NkcDIu
cGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDCB3QYIKwYB
BQUHAQEEgdAwgc0wMwYIKwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1T
ZXJ2ZXIvT0NTUDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSgYIKwYBBQUHMAKGPmh0dHA6Ly9j
ZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtZzItY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0
MA0GCSqGSIb3DQEBCwUAA4IBAQCBeEWkTqR/DlXwCbFqPnjMaDWpHPOVnj/z+N9rOHeJLI21
rT7H8pTNoAauusyosa0zCLYkhmI2THhuUPDVbmCNT1IxQ5dGdfBi5G5mUcFCMWdQ5UnnOR7L
n8qGSN4IFP8VSytmm6A4nwDO/afr0X9XLchMX9wQEZc+lgQCXISoKTlslPwQkgZ7nu7YRrQb
tQMMONncsKk/cQYLsgMHM8KNSGMlJTx6e1du94oFOO+4oK4v9NsH1VuEGMGpuEvObJAaguS5
Pfp38dIfMwK/U+d2+dwmJUFvL6Yb+qQTkPp8ftkLYF3sv8pBoGH7EUkp2KgtdRXYShjqFu9V
NCIaE40GMIIF3TCCBMWgAwIBAgIMJLUFOr7DT1PAbUHrMA0GCSqGSIb3DQEBCwUAMIGNMQsw
CQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRz
Y2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQD
DBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBMB4XDTIxMDUwNzE4MzIxMloXDTI0MDUw
NjE4MzIxMlowbjELMAkGA1UEBhMCREUxHTAbBgNVBAoMFFVuaXZlcnNpdGFldCBSb3N0b2Nr
MREwDwYDVQQEDAhCZWljaGxlcjERMA8GA1UEKgwIQmVuamFtaW4xGjAYBgNVBAMMEUJlbmph
bWluIEJlaWNobGVyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2b8u90iXRBjH
yBjGxC1OB7LXQfzdDYQ7JSdKvmpmyJKFuljDEIy5yYzjRHee0+Kf5DhrSgshWuvYAD1sIqQF
WlM38YTJRtwq9NF6yCdZQgxwaR8qUplUw72d/PCqD+KjFyj8scb32EOclVXY9UpEYeGp1BnG
66o9Oewbk4rdHqeYDt/9VDPZOmi5YYtXUfwITZ/A6LpgGYf+NDQHRWcmG5thbvcXVYvSOwrm
vZnf8ZW4GbMsTorXWKFqx3gntf5VmY/xZ7XH4mE1V9gtNAo5XaTpj9g3ncJel1jEMtii1DeH
/tnP5ICo6GabZhyUfRo0vYGQhBGYqRm5vMowdqJ38wIDAQABo4ICWTCCAlUwPgYDVR0gBDcw
NTAPBg0rBgEEAYGtIYIsAQEEMBAGDisGAQQBga0hgiwBAQQIMBAGDisGAQQBga0hgiwCAQQI
MAkGA1UdEwQCMAAwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDAdBgNVHQ4EFgQUVUQ/tNKbRqzbUgK5NMo8iU5mwfswHwYDVR0jBBgwFoAUazqYi/ny
U4na4K2yMh4JH+iqO3QwKwYDVR0RBCQwIoEgQmVuamFtaW4uQmVpY2hsZXJAdW5pLXJvc3Rv
Y2suZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5aHR0cDovL2NkcDEucGNhLmRmbi5kZS9kZm4t
Y2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2FjcmwuY3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2Eu
ZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEB
BIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVy
L09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2Jh
bC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAyLnBj
YS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZI
hvcNAQELBQADggEBACOufP2NVgvUwvjvP2WPeIHDEVtJ/+s/Mj0LWp5soBW7NigeBcLIuEk0
2SCxCrfhn2KP9UtQbVecIbJ1swZDyLvhth/fFarUy0oVjkljW3C9v5Ahsl+XGt0vuykJjyz5
KDlioNEAG3aMrfeWA/wAMJLDZ62xGHJZR94PgiFtyMpuxfMHy0INKPaxLjS6xDESL8ecqHTq
Q53DDAPudkZg7aUllBEufBk4aS3mBO1Gl2kOXR/1om14+7fKMxiQCbpaPiJH9VA0txBJfnfk
KeFTOAf9OdtZ77WWZTEA9JLLrcG9l44WJt7DM5Ui38NC/ZBprX4IVDhOdoIgv5uWUVTHVIwx
ggQLMIIEBwIBATCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQQIMJLUF
Or7DT1PAbUHrMA0GCWCGSAFlAwQCAQUAoIICPTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MjcyMDI4MjZaMC8GCSqGSIb3DQEJBDEiBCBNeLI5oZbR
OiGs7Tdy1GWObL92G+WbAdBdqdYPz2C34zBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQB
KjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMC
AgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGvBgkrBgEEAYI3EAQxgaEwgZ4wgY0xCzAJ
BgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNj
aGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsMB0RGTi1QS0kxJTAjBgNVBAMM
HERGTi1WZXJlaW4gR2xvYmFsIElzc3VpbmcgQ0ECDCS1BTq+w09TwG1B6zCBsQYLKoZIhvcN
AQkQAgsxgaGggZ4wgY0xCzAJBgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVyIEZvZXJk
ZXJ1bmcgZWluZXMgRGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsM
B0RGTi1QS0kxJTAjBgNVBAMMHERGTi1WZXJlaW4gR2xvYmFsIElzc3VpbmcgQ0ECDCS1BTq+
w09TwG1B6zANBgkqhkiG9w0BAQEFAASCAQByVyKKPyIK8cCYxdvIvNLUhIpTucvwciEKs4Hy
zzIBor8CLP3RgiFpotHKv2UkVKlWKXCzZpPYKLn3U+JZOJpjv2PvH+5SNCO1Y6eGMEgvFbZl
s1BzitZAw8FjcNqrmigp46EB1RgI5rvVoIYnd6LJ4Ts1Nko+Fhq5tGXxWDSivx6VUx8lRwFu
P9x0s/Ak0dCzeJIa/01/1XVwkqdB9NJDUv5ZxyrNSWdPKuiZLpdfhXcqrOp2IN3UU7JLhK+7
q72tgRAF3MVTR/qG3huXxJoUSNQBnJQ77QDCpZzb5vsxYFDnjZd7MLM7HljX9hgoJT0hddwl
xa1PRtWSy3iBDOtBAAAAAAAA
--------------ms040807060402020002030106--

