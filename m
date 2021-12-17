Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9931478E35
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbhLQOqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:46:02 -0500
Received: from mail-m17643.qiye.163.com ([59.111.176.43]:18242 "EHLO
        mail-m17643.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhLQOqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:46:01 -0500
DKIM-Signature: a=rsa-sha256;
        b=i+XgBhIIKm3biOwni57p1T4yRRwCuDeHBATCR2WaXR0Oxch5tylpd4KGmigadM3tmMV2gtIX65HQ8TWtn97UjuLKnomu0xxwHz8YcCa46a+1IvJdwnOhXyljbGs65+I+kcK1omfYgICWCZa8g7hYu/pkKvk3NLOXWSUcLR+3wIk=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=5FMw7kp1HH8RVuayQYlBDiL3oMoktV9Ah1Z/ALYgqdw=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [58.251.74.232])
        by mail-m17643.qiye.163.com (Hmail) with ESMTPA id 2854D7E0371;
        Fri, 17 Dec 2021 22:45:59 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     robh@kernel.org
Cc:     akingchen@vivo.com, balbi@kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel@vivo.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        s.shtylyov@omp.ru
Subject: Re: [PATCH 2/2] dt-bindings: usb: document snps,dis_split_quirk property in dwc3
Date:   Fri, 17 Dec 2021 22:45:44 +0800
Message-Id: <20211217144544.7147-1-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YbufNsBtiIzbm+9k@robh.at.kernel.org>
References: <YbufNsBtiIzbm+9k@robh.at.kernel.org>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRpMSUNWSkhIGk8YGBhLQx
        hMVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pwg6Qio*IT5KHzY*NgkCLCw4
        N0JPC1FVSlVKTUhCTE5JSE5CTUJKVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSElZV1kIAVlBSU9NTjcG
X-HM-Tid: 0a7dc8db5e05d999kuws2854d7e0371
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Add snps,dis_split_quirk property for dwc3 controller
>> >>
>> >> Signed-off-by: Yaqin Pan <akingchen@vivo.com>
>> >> ---
>> >>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>> >>   1 file changed, 6 insertions(+)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> >> index 41416fbd92aa..e9615ca8f447 100644
>> >> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> >> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> >> @@ -226,6 +226,12 @@ properties:
>> >>         avoid -EPROTO errors with usbhid on some devices (Hikey 970).
>> >>       type: boolean
>> >>   +  snps,dis_split_quirk:
>
>I'm tired of the never ending DWC3 quirks. Imply this from the 
>compatible unless it varies by board.

Yes, this is a DWC3 controller compatible issue.

>
>Also, don't use '_' in DT names.

Sure, i will change "snps,dis_split_quirk" to "snps,dis-split-quirk".

>
>> >> +    description:
>> >> +      When set, change the way host controller schedules transations for a Control transfer.
>> > 
>> >    Transactions.
>> > 
>> >> +      Needed to avoid emurate some devices fail.
>> > 
>> >    Avoid failing to enumerating some devices?

Yes. Avoid failing to enumerate some devices.

>> 
>>    Sorry. enumarate. :-)

> Or enumerate
