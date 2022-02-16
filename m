Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4E84B8535
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiBPKBg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Feb 2022 05:01:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiBPKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:01:34 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D75A71FA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:01:22 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-125-zknZPiwIOKCgjs6-SThh8g-1; Wed, 16 Feb 2022 10:01:20 +0000
X-MC-Unique: zknZPiwIOKCgjs6-SThh8g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 16 Feb 2022 10:01:18 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 16 Feb 2022 10:01:18 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Phillip Potter' <phil@philpotter.co.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "martin@kaiser.cx" <martin@kaiser.cx>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paskripkin@gmail.com" <paskripkin@gmail.com>
Subject: RE: [PATCH v2 15/15] staging: r8188eu: correct long line warnings
 near prior DBG_88E calls
Thread-Topic: [PATCH v2 15/15] staging: r8188eu: correct long line warnings
 near prior DBG_88E calls
Thread-Index: AQHYItG4AG5zz49180KoVbkPst1S56yV8RBA
Date:   Wed, 16 Feb 2022 10:01:18 +0000
Message-ID: <84f4a761263444c2940165dc403afb33@AcuMS.aculab.com>
References: <20220216010709.791-1-phil@philpotter.co.uk>
 <20220216010709.791-16-phil@philpotter.co.uk>
In-Reply-To: <20220216010709.791-16-phil@philpotter.co.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phillip Potter
> Sent: 16 February 2022 01:07
> 
> Where it is possible (without out-of-patch-series-scope large scale
> refactoring), correct code to remove checkpatch warnings about lines
> that are too long, also correcting operator spacing where appropriate
> for these lines as well. These warnings occur mostly due to so many
> DBG_88E removals and parentheses tweaks etc. being adjacent to such
> long lines, which are therefore included in the resultant diff.
...

Somewhere my copy of this seems to have got its tabs deleted.
I blame outlook :-)

> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index ddc3a2c8aaca..d68611ef22f8 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -382,7 +382,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  if (protocol == ETH_P_IP) {
>  struct iphdr *iph = (struct iphdr *)(skb->data + ETH_HLEN);
> 
> -if (((unsigned char *)(iph) + (iph->ihl<<2)) >= (skb->data + ETH_HLEN + skb->len))
> +if (((unsigned char *)(iph) + (iph->ihl << 2)) >= (skb->data + ETH_HLEN + skb->len))

You can delete at least three sets of () from that line.

>  return -1;
> 
>  switch (method) {
> @@ -451,7 +451,11 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  pOldTag = (struct pppoe_tag *)__nat25_find_pppoe_tag(ph, ntohs(PTT_RELAY_SID));
>  if (pOldTag) { /*  if SID existed, copy old value and delete it */
>  old_tag_len = ntohs(pOldTag->tag_len);
> -if (old_tag_len+TAG_HDR_LEN+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN > sizeof(tag_buf))
> +if (old_tag_len +
> +    TAG_HDR_LEN +
> +    MAGIC_CODE_LEN +
> +    RTL_RELAY_TAG_LEN >
> +    sizeof(tag_buf))
>  return -1;

That change really doesn't help readability at all.
There isn't much point shortening it that much like that, especially
since the here is a line that is nearly as long just above.

The real fix is to reduce the number of levels of indentation
to something sane.
I suspect that use of continue, break and return will help.

The other line length changes have much the same problem
but not as sever.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

