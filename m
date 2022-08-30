Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818475A625A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiH3Lp4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Aug 2022 07:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiH3Lpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:45:43 -0400
X-Greylist: delayed 79003 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Aug 2022 04:45:40 PDT
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC015142B;
        Tue, 30 Aug 2022 04:45:38 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 1C92CE000C;
        Tue, 30 Aug 2022 11:45:34 +0000 (UTC)
Message-ID: <1eac81c95f4d9c399421bffb6ac61511940c9978.camel@hadess.net>
Subject: Re: [v2 3/5] HID: logitech-hidpp: Remove special-casing of
 Bluetooth devices
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Tue, 30 Aug 2022 13:45:34 +0200
In-Reply-To: <20220830113615.4414-3-hadess@hadess.net>
References: <20220830113615.4414-1-hadess@hadess.net>
         <20220830113615.4414-3-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-30 at 13:36 +0200, Bastien Nocera wrote:
> Now that all the Logitech Bluetooth devices are probed for HID++
> support, remove the handling of those 2 devices without any quirks,
> as
> they're duplicates.

This one was lacking a sign-off.

> ---
>  drivers/hid/hid-logitech-hidpp.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index 641c897bf714..98ebedb73d98 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4350,13 +4350,9 @@ static const struct hid_device_id
> hidpp_devices[] = {
>         { /* MX5500 keyboard over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
>           .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
> -       { /* M-RCQ142 V470 Cordless Laser Mouse over Bluetooth */
> -         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb008) },
>         { /* MX Master mouse over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
>           .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { /* MX Ergo trackball over Bluetooth */
> -         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01d) },
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
>           .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
>         { /* MX Master 3 mouse over Bluetooth */

