Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1EB4AAFE5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 15:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242078AbiBFOQg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 6 Feb 2022 09:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiBFOQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 09:16:33 -0500
X-Greylist: delayed 2023 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 06:16:31 PST
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E5A7C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 06:16:31 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-172-J1tvwRiQPeqVqBMlrnKtLg-1; Sun, 06 Feb 2022 14:16:28 +0000
X-MC-Unique: J1tvwRiQPeqVqBMlrnKtLg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sun, 6 Feb 2022 14:16:26 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sun, 6 Feb 2022 14:16:26 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'joelcchangg@gmail.com'" <joelcchangg@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.com" <gregkh@linuxfoundation.com>
Subject: RE: [PATCH] staging: octeon-usb: Fix 'should not end with '(''
Thread-Topic: [PATCH] staging: octeon-usb: Fix 'should not end with '(''
Thread-Index: AQHYGy2lT3+mOj+jAkq4B/NGasIIi6yGkYKQ
Date:   Sun, 6 Feb 2022 14:16:26 +0000
Message-ID: <c0b504dd1f254f19b6ff60948684303b@AcuMS.aculab.com>
References: <20220206074615.3527-1-joelcchangg@gmail.com>
In-Reply-To: <20220206074615.3527-1-joelcchangg@gmail.com>
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
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: joelcchangg@gmail.com
> Sent: 06 February 2022 07:46
> 
> This patch fixes the checkpatch.pl check:
> 
> CHECK: Line should not end with '('
> 
> at lines 1802, 1807 and at some function headers.
> 
> Signed-off-by: Joel Camilo Chang Gonzalez <joelcchangg@gmail.com>
> ---
>  drivers/staging/octeon-usb/octeon-hcd.c | 67 +++++++++++--------------
>  1 file changed, 29 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> index a1cd81d4a114..60e8354104e6 100644
> --- a/drivers/staging/octeon-usb/octeon-hcd.c
> +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> @@ -1792,23 +1792,18 @@ static void cvmx_usb_start_channel(struct octeon_hcd *usb, int channel,
>  	case CVMX_USB_TRANSFER_INTERRUPT:
>  		break;
>  	case CVMX_USB_TRANSFER_ISOCHRONOUS:
> -		if (!cvmx_usb_pipe_needs_split(usb, pipe)) {
> +		if (!cvmx_usb_pipe_needs_split(usb, pipe) &&
> +		    pipe->transfer_dir == CVMX_USB_DIRECTION_OUT) {
>  			/*
>  			 * ISO transactions require different PIDs depending on
>  			 * direction and how many packets are needed
>  			 */
> -			if (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT) {
> -				if (pipe->multi_count < 2) /* Need DATA0 */
> -					USB_SET_FIELD32(
> -						CVMX_USBCX_HCTSIZX(channel,
> -								   usb->index),
> +			if (pipe->multi_count < 2) /* Need DATA0 */
> +				USB_SET_FIELD32(CVMX_USBCX_HCTSIZX(channel, usb->index),
>  						cvmx_usbcx_hctsizx, pid, 0);
> -				else /* Need MDATA */
> -					USB_SET_FIELD32(
> -						CVMX_USBCX_HCTSIZX(channel,
> -								   usb->index),
> +			else /* Need MDATA */
> +				USB_SET_FIELD32(CVMX_USBCX_HCTSIZX(channel, usb->index),
>  						cvmx_usbcx_hctsizx, pid, 3);
> -			}
>  		}
>  		break;
>  	}

What has that hunk got to do with the patch description?

> @@ -2121,17 +2116,17 @@ static void cvmx_usb_complete(struct octeon_hcd *usb,
>   *
>   * Returns: Transaction or NULL on failure.
>   */
> -static struct cvmx_usb_transaction *cvmx_usb_submit_transaction(
> -				struct octeon_hcd *usb,
> -				struct cvmx_usb_pipe *pipe,
> -				enum cvmx_usb_transfer type,
> -				u64 buffer,
> -				int buffer_length,
> -				u64 control_header,
> -				int iso_start_frame,
> -				int iso_number_packets,
> -				struct cvmx_usb_iso_packet *iso_packets,
> -				struct urb *urb)
> +static struct cvmx_usb_transaction *cvmx_usb_submit_transaction(struct octeon_hcd *usb,
> +								struct cvmx_usb_pipe *pipe,
> +								enum cvmx_usb_transfer type,
> +								u64 buffer,
> +								int buffer_length,
> +								u64 control_header,
> +								int iso_start_frame,
> +								int iso_number_packets,
> +								struct cvmx_usb_iso_packet
> +									*iso_packets,
> +								struct urb *urb)

Those lines are now far longer than is 'nice'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

