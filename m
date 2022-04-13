Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F984FF31E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiDMJQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiDMJQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:16:03 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271091EC63;
        Wed, 13 Apr 2022 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649841222;
  x=1681377222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=30FsYBYJWmfcj1JRV12IWMcoDT6mD1ixh44bhrplMVE=;
  b=jXqluSO2xW1C4aFle67KMnhZ5T7CgzARiPF6LFgVWcHBLipfhskQpZOi
   NEWFBf6emFx/6B+MtTpfDy2kxsxcAj2O/sDZi0tA7urFDceWuIFeq0Ozx
   r71eX70/gLstBCUZ1fWIGPB/XgkcGih1ldIRrXstCLVYWoEDv5Sd+ZgLc
   fuee/yYNirF6XoPU4t8YHAhyqn3O9AFQCMCdEib1kTMtQSr9lhqdhzk09
   3tugImeQZs6a0PqbP60IxCXkmul94d9ZEihzQrO2VPxii2XaOFv/1g15P
   PVgimI2rp0rCHgpou59QRz3f2f+4IOv0Sf65Ym0wJw1IxwQmkMoRc4Tc/
   Q==;
From:   Camel Guo <Camel.Guo@axis.com>
To:     Rob Herring <robh@kernel.org>, Camel Guo <Camel.Guo@axis.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
Thread-Topic: [PATCH v2 1/2] dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
Thread-Index: AQHYTnSVlOi/D1pm+0GzHpPjzLmB6qzsrDMAgADkJgA=
Date:   Wed, 13 Apr 2022 09:13:39 +0000
Message-ID: <77167ffd-5674-9f6f-df51-3233e67fe9a7@axis.com>
References: <20220412135232.1943677-1-camel.guo@axis.com>
 <20220412135232.1943677-2-camel.guo@axis.com>
 <YlXwyKkkC1VoPpjU@robh.at.kernel.org>
In-Reply-To: <YlXwyKkkC1VoPpjU@robh.at.kernel.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: se-mail03w.axis.com (15.01.2375.024)
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <37FBBC431566914FBE460EE99CBA1F17@exhub.se.axis.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 23:36, Rob Herring wrote:
> On Tue, Apr 12, 2022 at 03:52:31PM +0200, Camel Guo wrote:
>> Document the TMP401, TMP411 and TMP43x device devicetree bindings
>>=20
>> Signed-off-by: Camel Guo <camel.guo@axis.com>
>> ---
>>=20
>> +properties:
>> +=A0 compatible:
>> +=A0=A0=A0 enum:
>> +=A0=A0=A0=A0=A0 - ti,tmp401
>> +=A0=A0=A0=A0=A0 - ti,tmp411
>> +=A0=A0=A0=A0=A0 - ti,tmp431
>> +=A0=A0=A0=A0=A0 - ti,tmp432
>> +=A0=A0=A0=A0=A0 - ti,tmp435
>> +
>> +=A0 reg:
>> +=A0=A0=A0 maxItems: 1
>> +
>=20
>> +=A0 '#address-cells':
>> +=A0=A0=A0 const: 1
>> +
>> +=A0 '#size-cells':
>> +=A0=A0=A0 const: 0
>=20
> You don't have any child nodes and these are for child nodes with 'reg'.

Ack! I will fix it in v3.
>=20
>> +
>> +=A0 ti,extended-range-enable:
>> +=A0=A0=A0 description:
>> +=A0=A0=A0=A0=A0 When set, this sensor measures over extended temperatur=
e range.
>> +=A0=A0=A0 type: boolean
>> +
>> +=A0 ti,n-factor:
>=20
> Funny, I just ran across this property today for tmp421...
>=20
> Can the schema be shared?

Yes, this property is in ti,tmp421.yaml and ti,tmp464.yaml as well. But=20
I guess maybe it is better to separate tmp401 from them.

That is because the chips supported in ti,tmp421,yaml has three channels=20
and the chips supported in ti,tmp464.yaml has eight channels and this=20
property n-factor is for each channel/child node. But the chips=20
supported in ti,tmp401.yaml only has one channel. n-factor is for this=20
chip.

>=20
>> +=A0=A0=A0 description:
>> +=A0=A0=A0=A0=A0 value to be used for converting remote channel measurem=
ents to
>> +=A0=A0=A0=A0=A0 temperature.
>> +=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/uint32
>> +=A0=A0=A0 items:
>> +=A0=A0=A0=A0=A0 minimum: 0
>> +=A0=A0=A0=A0=A0 maximum: 255
>=20
> Isn't this property signed and should be -128 to -127? The code treats
> the existing cases as signed. One schema is correct and one is like you
> have it.

Ack! will fix it in v3

>=20
>> +
>> +=A0 ti,beta-compensation:
>> +=A0=A0=A0 description:
>> +=A0=A0=A0=A0=A0 value to select beta correction range.
>> +=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/uint32
>> +=A0=A0=A0 items:
>> +=A0=A0=A0=A0=A0 minimum: 0
>> +=A0=A0=A0=A0=A0 maximum: 15
>=20
> Drop 'items'. It is not an array.

Not sure if I understand correctly. Do you means it should be like this?=20
If so, I guess ti,n-factor should also be changed like this. Am I right?

   ti,beta-compensation:
    description:
      value to select beta correction range.
      $ref: /schemas/types.yaml#/definitions/uint32
      minimum: 0
      maximum: 15

>=20
>> +
>> +allOf:
>> +=A0 - if:
>> +=A0=A0=A0=A0=A0 properties:
>> +=A0=A0=A0=A0=A0=A0=A0 compatible:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 contains:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - ti,tmp401
>> +=A0=A0=A0 then:
>> +=A0=A0=A0=A0=A0 properties:
>> +=A0=A0=A0=A0=A0=A0=A0 ti,n-factor: false
>> +
>> +=A0 - if:
>> +=A0=A0=A0=A0=A0 properties:
>> +=A0=A0=A0=A0=A0=A0=A0 compatible:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 contains:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - ti,tmp401
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - ti,tmp411
>> +=A0=A0=A0 then:
>> +=A0=A0=A0=A0=A0 properties:
>> +=A0=A0=A0=A0=A0=A0=A0 ti,beta-compensation: false
>> +
>> +required:
>> +=A0 - compatible
>> +=A0 - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +=A0 - |
>> +=A0=A0=A0 i2c {
>> +=A0=A0=A0=A0=A0 #address-cells =3D <1>;
>> +=A0=A0=A0=A0=A0 #size-cells =3D <0>;
>> +
>> +=A0=A0=A0=A0=A0 sensor@4c {
>> +=A0=A0=A0=A0=A0=A0=A0 compatible =3D "ti,tmp401";
>> +=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x4c>;
>> +=A0=A0=A0=A0=A0 };
>> +=A0=A0=A0 };
>> +=A0 - |
>> +=A0=A0=A0 i2c {
>> +=A0=A0=A0=A0=A0 #address-cells =3D <1>;
>> +=A0=A0=A0=A0=A0 #size-cells =3D <0>;
>> +
>> +=A0=A0=A0=A0=A0 sensor@4c {
>> +=A0=A0=A0=A0=A0=A0=A0 compatible =3D "ti,tmp431";
>> +=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x4c>;
>> +=A0=A0=A0=A0=A0=A0=A0 ti,extended-range-enable;
>> +=A0=A0=A0=A0=A0=A0=A0 ti,n-factor =3D <0x3b>;
>> +=A0=A0=A0=A0=A0=A0=A0 ti,beta-compensation =3D <0x7>;
>> +=A0=A0=A0=A0=A0 };
>> +=A0=A0=A0 };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 61d9f114c37f..6b0d8f5cc68e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19838,6 +19838,7 @@ TMP401 HARDWARE MONITOR DRIVER
>>=A0 M:=A0=A0 Guenter Roeck <linux@roeck-us.net>
>>=A0 L:=A0=A0 linux-hwmon@vger.kernel.org
>>=A0 S:=A0=A0 Maintained
>> +F:=A0=A0 Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
>>=A0 F:=A0=A0 Documentation/hwmon/tmp401.rst
>>=A0 F:=A0=A0 drivers/hwmon/tmp401.c
>> =20
>> --=20
>> 2.30.2
>>=20
>>=20

Thanks for your review. I will fix most of these comments in v3.

