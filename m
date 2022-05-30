Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF6E537493
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiE3Fut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 01:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiE3Fuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 01:50:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6640F64709;
        Sun, 29 May 2022 22:50:44 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=HldmfFVPd4l5AfRP+32a2B2weT6pXhnieMSwUlkUTqrzfepcluu5p0rBkXs5/Re4WWp28k6QzQod6i4LbrEv8FJMhpbq5OoCzsguUtGICTWZHxpXspGFxFgjHKnXeI6TbeXe6up7w+gF4xtjpBBN2VuxfbTVpFxDyvEugxJAs9lO6vJz460+YDeaanFhJlOngRWqAawcWpynlii9k74Dzt6ZvjHjbD78NAnYp/NCJRfgFtsW0XuZcvIE8CRpQx46w0Jg8tRDYssie8oxiMIwzndSG/PCn2c44/ldxnw1ksx1fg81dEo/jeStKZROK+EFBWp8iOSEuVld8Sc/00f8Cw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f6Znw2AK9nKVYhZXx1I1B2giG8eJgq5xesyE0rHSgA=;
 b=mlw3alPTwyXcv5pV54BWG129Yym0vQvYldNZmuy8AuRz5JS9TKq0fVA7esdI9XdWqq9d0ObYOLfp65gptpfUBAhI+59gF0SxKzJBiemz4uuskRaCNgfh4o0JOod+VzVUwlSNi7pmVUFgdFKN1B/xD17noEMMU46a2DbTSk3Ofo8aang0mzPzLb3IDFdJLPS8FhIzveeh0HPpL9qaDmmsGf4n6aeJTptSq8jInN3A7+EEdZRrzY6+du78FABS4tboDmqCkIsl9x4XumvWjYqvqQah28KE22Mn17koIE3xyoxkRUzmzpZzN+blrg84j8MwXc4XYp18LxBslFqL1qDI3g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=gmail.com smtp.mailfrom=topicproducts.com;
 dmarc=none action=none header.from=topic.nl; dkim=none (message not signed);
 arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f6Znw2AK9nKVYhZXx1I1B2giG8eJgq5xesyE0rHSgA=;
 b=Zgsgt2FoDRRiuVPux9HVEqcdREYmHRUa8bnaWC8A+Ua+2qxUgJjC0p9s3zHmoUFmnn0qa8ubo4iqFTu1OyX0RJtqXt3hgyti0+ehWXH3P2/RzM6hqkS1s0w7y+WUUlxcjX7daqGfhTYm4TpS4LKDc/voH4R4bwnWmlK6gMcLLtmkFpq/8D0esXA6Dql6cPiaS4862c9PehWkmajqK9aMQvIMDzm9xM0Zfhg4YFd6FVXdBtkAAUqOe4b+YP/mlMx+ZNzOoLqflGnQKYiYxS3PVnZR7g7dKgojVGkAkz0RRthM7YyZO3US/xtUWlQm3kdwpRBmrqyo71YuoEa6xz+FLg==
Received: from AS9PR0301CA0019.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::29) by AM9PR04MB8634.eurprd04.prod.outlook.com
 (2603:10a6:20b:43d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 05:50:41 +0000
Received: from VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:468:cafe::cc) by AS9PR0301CA0019.outlook.office365.com
 (2603:10a6:20b:468::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Mon, 30 May 2022 05:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT018.mail.protection.outlook.com (10.152.2.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Mon, 30 May 2022 05:50:39 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (104.47.9.54) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 30 May 2022 05:50:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7y8J6CGKsMoUTlxGc1cA3yzymz5wssggXXPirRTyC/mAJ2uusNqvWW5Qo438//KFChmjepL6qiwvTQt5qDxaq5+K2Czg9GKyMotbaEDc8AXPEYDLey79bz1Ahm03Mq1KuTpyVC4dllk5jhYUHmajP/RfU1g5GONOD6crTQthvV0eSfqtH5R3bjsesuMCL9aqTZTGhRltLfbxFLKFfwUU9i6Mz0+1fbdfoZCq436rkoxFJgY4MM+MXIVoSG5k+nFQZOXTZt/9SqpJxhOZO4RSQcVOYGqkZR7IblAHSzld9xzmHrDtNFJzFRy8zWDhvsJaLgNQ52Ior8glfg0/hXG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze6/JmkznN+DudS8VM8b6BGSfUt+HMVvQrZQTodGyHQ=;
 b=I1d+dx8epEnuD5E0Ndd1bum2tlz8WN5ZNnVJgTC+loPptSofNtg7LeLBd+feyeMMJ+cwKr1P5SN2Aa8tdXjd8LCwHD9cRsWJ2yAqsEuh+Uwm+sjSCcuiG1ngK5hBh/8Z1sr4+3ctgS3/NjA25ZmBWsTJydGfcglP9yCz//pPSdPOWy7OV6b3QjWUCuypvp/1Cp0EjuJqhGFx1dai6/RKZzz4C3GW2Qq09XiuChtASy5NC5k18TGgwchnEVKQuQMc1PwqkwSASkMPcuay5RCHqDdvgw0MNFqcH4dyY1Caq83Y2JRVmgrS+L2IY9gDtByR+R9OxfZoFYwirOyAnM0eWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by VI1PR0401MB2607.eurprd04.prod.outlook.com (2603:10a6:800:58::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 05:50:33 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::7075:13eb:3b6e:4e14]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::7075:13eb:3b6e:4e14%6]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 05:50:33 +0000
Message-ID: <faa70977-311f-08fb-bb3d-5dfabdab2b15@topic.nl>
Date:   Mon, 30 May 2022 07:50:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Input: st1232 - Support power supply regulators
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, martink@posteo.de,
        geert+renesas@glider.be, john@metanate.com, hechtb@gmail.com
References: <20220524081216.8550-1-mike.looijmans@topic.nl>
 <YpGpdsAJicTqHbeY@google.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.448f4393-43fc-4ee3-8849-d41a20e1be99@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.95a3a45c-fed7-48c4-9f4f-59d66a927377@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
In-Reply-To: <YpGpdsAJicTqHbeY@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM4PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:205::18)
 To DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: dc871101-94c5-4954-ada1-08da4200540e
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2607:EE_|VE1EUR01FT018:EE_|AM9PR04MB8634:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB8634A09D733087EB083511DF96DD9@AM9PR04MB8634.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vWrz5fP2Soc5Fi5M06eAzQ5bazYUVIL6AeJh7rIVxcV8oLtP+Gx0prraM+jo8d3HDdX9RQTfJTgCL5x0IFKvHBCkOK/3cXArQjXQ5p7+l9HWGY3ihxHCweny5kDAXqS9x4aEvpol1JwZGjkBtOW6fmvPc2Ww6vmzx2VqtOydVVpsiPHAXiMvLSv3JOtuOJMd1SZWfhhCjDKnEidpFJTksMOJ0fWeyoPrHVMgAQRxwZOBo4ut5LpwK1achmFi0nOZEu9ArwpaM82NOfMABtzk0jvQrtU+Z8xYn9LjFoU7pR4Okmva8ykeE5+WajSE9uwvLNnTY1XqtCuYsFVyjAy+aaJm5bIHnhBwG4ovzZOEzC7CltM1OUggojX/fn7yirUFyFO4KXMqEo+01/UxkwRDyFaS6/EXbyDvIxyLn8mtREz2qslahJnsJHFALw8nHouz34QrjzMvV7v88Rs83emNoA5Na6uFNveV4zARXsJSpBSCtRikJP6xz3EEPNxZoWGOcd/5cuddzQat+R0inBK1KEyMvq6jnparUVilvKCfHy7TZovEyKeYtsnTp6umNnC9jEi8BZBKtkwa6EJIrMd1K59Dm39jekAfdyU2lllxLeFVFCugG/btoKKt4pGwO1FzLkS5s1rlVtgb6kUP6sWnl1rgDzRl2wOYs/r3XH42C+l9YyEiQvABDr5h34CiF4p/S0TMlqi6lpp6X0B8Pg3fSadZNGiAinRqHTjIaWkzDLLOzSP7n6vOGckbzeaQ/LwrvXJEDsbGSewk4rpixzhrBQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(39830400003)(376002)(346002)(396003)(366004)(4326008)(8676002)(66556008)(66946007)(66476007)(38350700002)(36916002)(83380400001)(31686004)(6916009)(38100700002)(316002)(36756003)(83170400001)(8936002)(26005)(5660300002)(6506007)(52116002)(31696002)(6512007)(186003)(508600001)(6486002)(7416002)(44832011)(2906002)(41300700001)(2616005)(53546011)(42882007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2607
X-CodeTwo-MessageID: 72f18deb-4906-46a5-b286-dade5da3e61a.20220530055037@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 97ca3db4-7fce-4261-3a5f-08da42004fe5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dul/0c8cctYMIrMtQ3/qZe2iGHqMsVUxu+NTuJuM2snYWbbna3dQG+4FBDcGSeNpJscV6MCPq5F2rzPfTe0x/HocpcfPe4/XV7T7B9mfBL7Z9hI9QfNRtQRResY/aHJiGsUK/hck/PhL/6IxMPa00lHl7zVywsktXPPL9+62ISF0fcwW7PgnKNeNQ7fqUR/DfcKuUezVA9FbMqPo8VcL1cUDFH3aZIALoak07KzEiWEgYVD0u60T1xDqbZoYhl7ncZl6NUj948V12p2qNwwtCwQ6YknpmsS7rtSSrEf/1M+uTy7oAWEHwxzRPBmAJY9MqKw8T+mN5+08/dRK3i8CC8pS/3+TIguZBiLUZF04U1fL9F806BPXK+YgfUUJBZxOA0KAUz4P7jh8VAAgg+HD4Yo5vvjcTeLP3+adgUgKjzftP7z/TNi7mpkuGUDDoGFbrc5b121ZT2w00lfw5e10bz1u4AnUntYcdSWKJmdtL6VxvGvRP2dR4x8RjOSBHJPHhf9Ro8dKCN4CNdVmgdk7xXG6upR2RuQ9BC/zQxsZJaYkHhyLstYJsdquz8PvczQxVSRa8Y7rZNVfva6KBOi80FjUWzSFqVbKTonGWJ95aNynG0k2Z4uhZ47gKyrJ94sQxHITRQagb0osavqqpAwEnotjTkEijRQ7MOoeJoFt/9wkABI06WKwTg9sHCi3FX7Ort3Pi9n2/1CdSTXSuso8gaGR0zkCXSvac6QndUy5luhx1UqdqrMYKyUDBTQGc81g+TKCPMqS7lo2GAqm2DMLsX9vtyJwT06bowbaIzVOWRw=
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230001)(4636009)(376002)(136003)(396003)(39830400003)(346002)(46966006)(36840700001)(83380400001)(36916002)(6486002)(316002)(36860700001)(8676002)(4326008)(15974865002)(53546011)(508600001)(2906002)(31686004)(6916009)(8936002)(26005)(40480700001)(5660300002)(7416002)(44832011)(6512007)(7596003)(41300700001)(83170400001)(70586007)(31696002)(36756003)(7636003)(82310400005)(42882007)(47076005)(2616005)(336012)(186003)(70206006)(6506007)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 05:50:39.5903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc871101-94c5-4954-ada1-08da4200540e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8634
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment inlined below (mailserver injects signature halfway through the=20
mail usually).


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 28-05-2022 06:47, Dmitry Torokhov wrote:
> Hi Mike,
>
> On Tue, May 24, 2022 at 10:12:16AM +0200, Mike Looijmans wrote:
>> Add support for the VDD and IOVDD power supply inputs. This allows the
>> chip to share its supplies with other components (e.g. panel) and manage
>> them.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>   .../input/touchscreen/sitronix,st1232.yaml    |  6 +++
>>   drivers/input/touchscreen/st1232.c            | 54 ++++++++++++++++---
>>   2 files changed, 52 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitroni=
x,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitroni=
x,st1232.yaml
>> index 1d8ca19fd37a..240be8d49232 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st123=
2.yaml
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st123=
2.yaml
>> @@ -28,6 +28,12 @@ properties:
>>       description: A phandle to the reset GPIO
>>       maxItems: 1
>>  =20
>> +  vdd-supply:
>> +    description: Power supply regulator for the chip
>> +
>> +  vddio-supply:
>> +    description: Power supply regulator for the I2C bus
>> +
>>   required:
>>     - compatible
>>     - reg
>> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscr=
een/st1232.c
>> index e38ba3e4f183..d9c9f6f1f11a 100644
>> --- a/drivers/input/touchscreen/st1232.c
>> +++ b/drivers/input/touchscreen/st1232.c
>> @@ -44,6 +44,11 @@
>>   #define REG_XY_COORDINATES	0x12
>>   #define ST_TS_MAX_FINGERS	10
>>  =20
>> +enum st1232_regulators {
>> +	ST1232_REGULATOR_VDD,
>> +	ST1232_REGULATOR_IOVDD,
>> +};
>> +
>>   struct st_chip_info {
>>   	bool	have_z;
>>   	u16	max_area;
>> @@ -56,6 +61,7 @@ struct st1232_ts_data {
>>   	struct touchscreen_properties prop;
>>   	struct dev_pm_qos_request low_latency_req;
>>   	struct gpio_desc *reset_gpio;
>> +	struct regulator_bulk_data regulators[2];
>>   	const struct st_chip_info *chip_info;
>>   	int read_buf_len;
>>   	u8 *read_buf;
>> @@ -197,17 +203,36 @@ static irqreturn_t st1232_ts_irq_handler(int irq, =
void *dev_id)
>>   	return IRQ_HANDLED;
>>   }
>>  =20
>> -static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
>> +static int st1232_ts_power_on(struct st1232_ts_data *ts)
>> +{
>> +	int err;
>> +
>> +	err =3D regulator_bulk_enable(ARRAY_SIZE(ts->regulators), ts->regulato=
rs);
>> +	if (err)
>> +		return err;
> Does it really make sense to try and handle regulators when reset gpio
> is not defined? Would it not be better to tie them to the presence of
> reset gpio to make sure we implement proper power on sequence?

I thought that's what we're doing here. The datasheet says 5ms between=20
power-good and reset de-assert. Whether or not the hardware guys=20
bothered to actually connect the reset is out of our hands. The=20
regulator is not mandatory either, we'll get a dummy supply from the=20
framework when not defined.

The main use case here is that if for example the panel and touchscreen=20
share a power supply, they can now turn off the power supply when not in=20
use.

>
>> +
>> +	usleep_range(5000, 6000);
>> +
>> +	if (ts->reset_gpio)
>> +		gpiod_set_value_cansleep(ts->reset_gpio, 0);
>> +
>> +	return 0;
>> +}
> Thanks.
>

--=20
Mike Looijmans

