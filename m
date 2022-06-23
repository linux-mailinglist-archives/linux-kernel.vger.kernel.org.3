Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D466556F59
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 02:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345677AbiFWAWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 20:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiFWAWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 20:22:08 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AE141621
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 17:22:04 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id RWS00159;
        Thu, 23 Jun 2022 08:21:59 +0800
Received: from jtjnmail201626.home.langchao.com (10.100.2.36) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 08:21:59 +0800
Received: from jtjnmail201620.home.langchao.com (10.100.2.20) by
 jtjnmail201626.home.langchao.com (10.100.2.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 08:21:59 +0800
Received: from jtjnmail201620.home.langchao.com ([fe80::24f6:b8e5:a824:6a6b])
 by jtjnmail201620.home.langchao.com ([fe80::24f6:b8e5:a824:6a6b%9]) with mapi
 id 15.01.2308.027; Thu, 23 Jun 2022 08:21:59 +0800
From:   =?gb2312?B?dG9tb3Jyb3cgV2FuZyAozfW1wsP3KQ==?= 
        <wangdeming@inspur.com>
To:     "mst@redhat.com" <mst@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSB2aXJ0aW9fcmluZzogcmVtb3ZlIHVubmVjZXNzYXJ5?=
 =?gb2312?B?IHRvX3Z2cSBjYWxsIGluIHZpcnRxdWV1ZV9kaXNhYmxlX2NiX3BhY2tlZA==?=
Thread-Topic: [PATCH] virtio_ring: remove unnecessary to_vvq call in
 virtqueue_disable_cb_packed
Thread-Index: AQHYhgzOe6meliZgrEeTXStwKwOJ/61a0TsAgAFQPQA=
Date:   Thu, 23 Jun 2022 00:21:59 +0000
Message-ID: <83fd2deadce046c69d4e3acb40b5e284@inspur.com>
References: <20220622075052.1560-1-wangdeming@inspur.com>
 <20220622081411-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220622081411-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.200.104.82]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=SHA1; boundary="----=_NextPart_000_0032_01D886DA.4E53D8E0"
MIME-Version: 1.0
tUid:   2022623082159b48894c8de610ca25bdf4a8c4384ca8b
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

------=_NextPart_000_0032_01D886DA.4E53D8E0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi=A3=AC
  The  35c51e093d956f6d058e193711c8d424817a44a9 patch has  maked  a =
similar
change
 =20
> Re: [PATCH] virtio_ring: remove unnecessary to_vvq call in
> virtqueue_disable_cb_packed
>=20
> On Wed, Jun 22, 2022 at 03:50:52AM -0400, Deming Wang wrote:
> > It passes '_vq' to virtqueue_use_indirect(), which still calls =
to_vvq
> > to get 'vq', let's directly pass 'vq'. It can avoid unnecessary call
> > of to_vvq in hot path.
> >
> > Signed-off-by: Deming Wang <wangdeming@inspur.com>
>=20
> I do not see the point of any of these patches. Sorry.
> If this is supposed to be an optimization, post some numbers pls.
>=20
>=20
> > ---
> >  drivers/virtio/virtio_ring.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c
> > b/drivers/virtio/virtio_ring.c index 13a7348cedff..af2b7785ed77 =
100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1475,10 +1475,8 @@ static void
> *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >  	return ret;
> >  }
> >
> > -static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
> > +static void virtqueue_disable_cb_packed(struct vring_virtqueue *vq)
> >  {
> > -	struct vring_virtqueue *vq =3D to_vvq(_vq);
> > -
> >  	if (vq->packed.event_flags_shadow !=3D
> VRING_PACKED_EVENT_FLAG_DISABLE) {
> >  		vq->packed.event_flags_shadow =3D
> VRING_PACKED_EVENT_FLAG_DISABLE;
> >  		vq->packed.vring.driver->flags =3D
> > @@ -2007,7 +2005,7 @@ void virtqueue_disable_cb(struct virtqueue =
*_vq)
> >  		return;
> >
> >  	if (vq->packed_ring)
> > -		virtqueue_disable_cb_packed(_vq);
> > +		virtqueue_disable_cb_packed(vq);
> >  	else
> >  		virtqueue_disable_cb_split(_vq);
> >  }
> > --
> > 2.27.0


------=_NextPart_000_0032_01D886DA.4E53D8E0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
AgICAIAwDgYIKoZIhvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMB0GA1UdDgQWBBT2m8+B
pv3zOH+FCDvTbpfMkvPbAzAfBgNVHSMEGDAWgBReWQOmtExYYJFO9h61pTmmMsE1ajCCAQ8GA1Ud
HwSCAQYwggECMIH/oIH8oIH5hoG6bGRhcDovLy9DTj1JTlNQVVItQ0EsQ049SlRDQTIwMTIsQ049
Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRp
b24sREM9aG9tZSxEQz1sYW5nY2hhbyxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9i
YXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hjpodHRwOi8vSlRDQTIwMTIuaG9t
ZS5sYW5nY2hhby5jb20vQ2VydEVucm9sbC9JTlNQVVItQ0EuY3JsMIIBKQYIKwYBBQUHAQEEggEb
MIIBFzCBsQYIKwYBBQUHMAKGgaRsZGFwOi8vL0NOPUlOU1BVUi1DQSxDTj1BSUEsQ049UHVibGlj
JTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ob21lLERD
PWxhbmdjaGFvLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNh
dGlvbkF1dGhvcml0eTBhBggrBgEFBQcwAoZVaHR0cDovL0pUQ0EyMDEyLmhvbWUubGFuZ2NoYW8u
Y29tL0NlcnRFbnJvbGwvSlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb21fSU5TUFVSLUNBLmNydDBH
BgNVHREEQDA+oCUGCisGAQQBgjcUAgOgFwwVd2FuZ2RlbWluZ0BpbnNwdXIuY29tgRV3YW5nZGVt
aW5nQGluc3B1ci5jb20wDQYJKoZIhvcNAQELBQADggEBAKD6Oh0Yu1g2xXDIaczYlx8WZiYqTi7t
bFCmsNT5DmNUfLaJre5UDyaWjgwW6Z/KN1X19Piy6oS8ex93gaeF4siDuQimREZoKxePJyUeyFs5
oC6kpsw95f/0RM5zhHb4I8L4AgplfwySCGAeMRr74rThzkYWfoU1AM+c8cBtViIispknx6KxJFo2
b533lCx168UKeNRb1n7pUANxFYd+1jjdRKCPrszdJcJddFmnLBetcnD4DG0ID62hnw+/g0KoAlfd
ORikFVBLobsDNy+NQ++5ZYgx1ahEQ6BESIjeWxut+2Zqis6Zbwd5ZsBhm892l5EdzJCuYe5xDEZw
0Z0bGvUxggOTMIIDjwIBATBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZ
FghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA
1tjc3okYpZWK7QAAAADW2DAJBgUrDgMCGgUAoIIB+DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA2MjMwMDIxNThaMCMGCSqGSIb3DQEJBDEWBBQr7dF8eFwZxeYJ
NjNCCcv/U6KY2jB/BgkrBgEEAYI3EAQxcjBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJ
kiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BV
Ui1DQQITfgAA1tjc3okYpZWK7QAAAADW2DCBgQYLKoZIhvcNAQkQAgsxcqBwMFkxEzARBgoJkiaJ
k/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhv
bWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA1tjc3okYpZWK7QAAAADW2DCBkwYJKoZIhvcNAQkP
MYGFMIGCMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAEC
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJ
YIZIAWUDBAICMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCe6FB6gPn46o8AFB2RfB91
pZDpQe+NditxNf9LnTqGZK4POJBglxi/JbEo2oSijGusKZyg931PwFGJfVxr+LN9tD54FTr1RnVz
YPuYyC07o/gJlz9l9mRecz8iFUlwlI/2besno8S0a9nfa0Npywqy9KdJniaygsGXxLmpT0EwS+u9
LcWXmxxUbyALRngVKVLW+cLhVyB0Zzd6lZXZbCaXLHZwpHBO2X4RDrXbMPDlPuc6JWIiYX+B+I8w
y7T7nS8lxJbHEPtWA55EV7UHZOT8Unn7/Vh75VqXm1wFcJFPo1fDCYRz92LI44YsLsj22FMvjBi3
w5anvsNFmjuUjxfsAAAAAAAA

------=_NextPart_000_0032_01D886DA.4E53D8E0--
