Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C552047E0CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347399AbhLWJTw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Dec 2021 04:19:52 -0500
Received: from aposti.net ([89.234.176.197]:33056 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239245AbhLWJTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:19:51 -0500
Date:   Thu, 23 Dec 2021 09:19:43 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Introduce common properties
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <VW9K4R.K71G6V70Q9T81@crapouillou.net>
In-Reply-To: <YcN+NwFu2m6WZCdE@robh.at.kernel.org>
References: <20211221175029.144906-1-paul@crapouillou.net>
        <20211221175029.144906-2-paul@crapouillou.net>
        <YcN+NwFu2m6WZCdE@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le mer., déc. 22 2021 at 15:36:23 -0400, Rob Herring <robh@kernel.org> 
a écrit :
> On Tue, Dec 21, 2021 at 05:50:28PM +0000, Paul Cercueil wrote:
>>  Introduce a file for common properties of hwmon sensors.
>> 
>>  As of now it contains only the "label" property, which can contain a
>>  descriptive label that allows to uniquely identify a device within 
>> the
>>  system.
> 
> I don't think we need this. What we need is a global (in dtschema)
> type definition and then any users just add 'label: true'.

Well, users would also need to set an actual label, otherwise this 
defeats the point :)

Cheers,
-Paul

> 
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   .../devicetree/bindings/hwmon/common.yaml     | 31 
>> +++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/hwmon/common.yaml
>> 
>>  diff --git a/Documentation/devicetree/bindings/hwmon/common.yaml 
>> b/Documentation/devicetree/bindings/hwmon/common.yaml
>>  new file mode 100644
>>  index 000000000000..997f74127d8c
>>  --- /dev/null
>>  +++ b/Documentation/devicetree/bindings/hwmon/common.yaml
>>  @@ -0,0 +1,31 @@
>>  +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id: http://devicetree.org/schemas/hwmon/common.yaml#
>>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  +
>>  +title: Common properties for hwmon sensors
>>  +
>>  +maintainers:
>>  +  - Jean Delvare <jdelvare@suse.com>
>>  +  - Guenter Roeck <linux@roeck-us.net>
>>  +
>>  +description: |
>>  +  This document defines device tree properties common to several 
>> hwmon
>>  +  sensors. It doesn't constitue a device tree binding 
>> specification by itself but
>>  +  is meant to be referenced by device tree bindings.
>>  +
>>  +  When referenced from sensor tree bindings the properties defined 
>> in this
>>  +  document are defined as follows. The sensor tree bindings are 
>> responsible for
>>  +  defining whether each property is required or optional.
>>  +
>>  +properties:
>>  +  label:
>>  +    $ref: /schemas/types.yaml#/definitions/string
>>  +    description: >
>>  +      Descriptive label that allows to uniquely identify a device 
>> within
>>  +      the system.
>>  +
>>  +additionalProperties: true
>>  +
>>  +...
>>  --
>>  2.34.1
>> 
>> 


