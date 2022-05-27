Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53116535E75
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350594AbiE0Knm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbiE0Knl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:43:41 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3346C3525C
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:43:34 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id WHT00028;
        Fri, 27 May 2022 18:43:28 +0800
Received: from jtjnmail201621.home.langchao.com (10.100.2.21) by
 jtjnmail201623.home.langchao.com (10.100.2.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 27 May 2022 18:43:30 +0800
Received: from jtjnmail201621.home.langchao.com ([fe80::31c7:1db7:6c09:282a])
 by jtjnmail201621.home.langchao.com ([fe80::31c7:1db7:6c09:282a%7]) with mapi
 id 15.01.2308.027; Fri, 27 May 2022 18:43:30 +0800
From:   =?gb2312?B?Qm8gTGl1ICjB9bKoKS3Ay7Ox0MXPog==?= <liubo03@inspur.com>
To:     "mst@redhat.com" <mst@redhat.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_balloon: check virtqueue_add_outbuf() return value
Thread-Topic: [PATCH] virtio_balloon: check virtqueue_add_outbuf() return
 value
Thread-Index: Adhxtgx68N9YbLOTtEWiBwAGkCp+BQ==
Date:   Fri, 27 May 2022 10:43:30 +0000
Message-ID: <4789cbbb9d59420abc86a9e225ef0bfd@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.200.104.97]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=SHA1; boundary="----=_NextPart_000_0057_01D871F9.A7E29770"
MIME-Version: 1.0
tUid:   2022527184328d812e525496b86a099cdd13c382715f6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_0057_01D871F9.A7E29770
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

The purpose of this patch is, virtqueue_add_outbuf() adding data to
virtqueue may succeed or fail. If successful, it will call =
virtqueue_kick()
to notifie the host backend driver, but if the virtqueue_add_outbuf() =
fails,
the data is not successfully added to the virtqueue, and the host =
back-end
driver does not need to be notified for processing.

Thanks.

-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: Michael S. Tsirkin <mst@redhat.com>=20
=B7=A2=CB=CD=CA=B1=BC=E4: 2022=C4=EA5=D4=C227=C8=D5 18:25
=CA=D5=BC=FE=C8=CB: Bo Liu (=C1=F5=B2=A8)-=C0=CB=B3=B1=D0=C5=CF=A2 =
<liubo03@inspur.com>
=B3=AD=CB=CD: david@redhat.com; jasowang@redhat.com;
virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
=D6=F7=CC=E2: Re: [PATCH] virtio_balloon: check virtqueue_add_outbuf() =
return value

On Thu, May 26, 2022 at 09:34:01PM -0400, Bo Liu wrote:
> virtqueue_add_outbuf() can fail, when it fails, there is no need to=20
> call the funciont virtqueue_kick().
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Sorry don't get it.
What's the point of this patch really?

> ---
>  drivers/virtio/virtio_balloon.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c=20
> b/drivers/virtio/virtio_balloon.c index b9737da6c4dd..0d7da4d95e1e=20
> 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -153,16 +153,18 @@ static void tell_host(struct virtio_balloon *vb, =

> struct virtqueue *vq)  {
>  	struct scatterlist sg;
>  	unsigned int len;
> +	int err;
> =20
>  	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
> =20
>  	/* We should always be able to add one buffer to an empty queue. */
> -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> -	virtqueue_kick(vq);
> -
> -	/* When host has read buffer, this completes via balloon_ack */
> -	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> +	err =3D virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> +	if (!err) {
> +		virtqueue_kick(vq);
> =20
> +		/* When host has read buffer, this completes via balloon_ack
*/
> +		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> +	}
>  }
> =20
>  static int virtballoon_free_page_report(struct=20
> page_reporting_dev_info *pr_dev_info, @@ -382,6 +384,7 @@ static void
stats_handle_request(struct virtio_balloon *vb)
>  	struct virtqueue *vq;
>  	struct scatterlist sg;
>  	unsigned int len, num_stats;
> +	int err;
> =20
>  	num_stats =3D update_balloon_stats(vb);
> =20
> @@ -389,8 +392,9 @@ static void stats_handle_request(struct =
virtio_balloon
*vb)
>  	if (!virtqueue_get_buf(vq, &len))
>  		return;
>  	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
> -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> -	virtqueue_kick(vq);
> +	err =3D virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> +	if (!err)
> +		virtqueue_kick(vq);
>  }
> =20
>  static inline s64 towards_target(struct virtio_balloon *vb)
> --
> 2.27.0


------=_NextPart_000_0057_01D871F9.A7E29770
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
9w0DAgICAIAwDgYIKoZIhvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMB0GA1UdDgQWBBTk
Hdp/y3+DuDJ13Q1YzgU9iV7NdzAfBgNVHSMEGDAWgBReWQOmtExYYJFO9h61pTmmMsE1ajCCAQ8G
A1UdHwSCAQYwggECMIH/oIH8oIH5hoG6bGRhcDovLy9DTj1JTlNQVVItQ0EsQ049SlRDQTIwMTIs
Q049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3Vy
YXRpb24sREM9aG9tZSxEQz1sYW5nY2hhbyxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlz
dD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hjpodHRwOi8vSlRDQTIwMTIu
aG9tZS5sYW5nY2hhby5jb20vQ2VydEVucm9sbC9JTlNQVVItQ0EuY3JsMIIBKQYIKwYBBQUHAQEE
ggEbMIIBFzCBsQYIKwYBBQUHMAKGgaRsZGFwOi8vL0NOPUlOU1BVUi1DQSxDTj1BSUEsQ049UHVi
bGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ob21l
LERDPWxhbmdjaGFvLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlm
aWNhdGlvbkF1dGhvcml0eTBhBggrBgEFBQcwAoZVaHR0cDovL0pUQ0EyMDEyLmhvbWUubGFuZ2No
YW8uY29tL0NlcnRFbnJvbGwvSlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb21fSU5TUFVSLUNBLmNy
dDBBBgNVHREEOjA4oCIGCisGAQQBgjcUAgOgFAwSbGl1Ym8wM0BpbnNwdXIuY29tgRJsaXVibzAz
QGluc3B1ci5jb20wDQYJKoZIhvcNAQELBQADggEBAA+BaY3B3qXmvZq7g7tZLzq2VQjU//XHTmyl
58GLDWdVHsuX3lrAGwEfLVnUodpvthjtb7T7xEUzJh4F62zLFSm8HOBPH1B+6SFQKChHZeM0pauv
Xr1krRtVv82RgLsU26XrXFUPN+NcPwt7vOw1zHOiDic4anL3A9gsuDljAi2l+CA5RY05yL+8oras
EAhOYL6+ks9aB8QiCxbZzShkDTMkrh0N1DjoBLaibtnlI/fxOUYM6vgdiI+FC02G41B364ZAc1ma
bSFvGIP6cIdr/olprPQOj9cq6zMi05qUBUj22hDvhcY0TlT4fEJSrvblp/LG6qTtVI3ilUAxhe8i
9cIxggOTMIIDjwIBATBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghs
YW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA0dHV
TGwIT1/wiwAAAADR0TAJBgUrDgMCGgUAoIIB+DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMjA1MjcxMDQzMjhaMCMGCSqGSIb3DQEJBDEWBBSTRkPhpH+K6XNRqhmj
jqTPBIBcjTB/BgkrBgEEAYI3EAQxcjBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJ
k/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1D
QQITfgAA0dHVTGwIT1/wiwAAAADR0TCBgQYLKoZIhvcNAQkQAgsxcqBwMFkxEzARBgoJkiaJk/Is
ZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUx
EjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA0dHVTGwIT1/wiwAAAADR0TCBkwYJKoZIhvcNAQkPMYGF
MIGCMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAICMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAr2RAg2mmXGPvaCu4Vc8GUrGkP
GsNokXit3OA4dbG1VLzmzhIzZo6PlyS4DmdjeGnkXI6rkRyspYxbYhAj4gTSv1IWS9AuKnVlFdDA
FPdhbZSyjluTWkr5n5Pd2GHIHtfv6Qk0YjLhzA+4SFh+wTio3Bapqls015hHldW5G0yfKztwUi9H
yZYt69SKk5Y/3T59yNQuNBbU1QD1j381eVBKanayWHtQfZpDMuo9h63ruuJcIaOHGOH6B39GA+uK
YmFGd6S9/MpxY2THXz4TXtW/T4i3ZCmHlrvyut928lWmR9hRl6XtZdH4GF0f786vfX5KFab9wh3U
o1RR4YE5HL6IAAAAAAAA

------=_NextPart_000_0057_01D871F9.A7E29770--
