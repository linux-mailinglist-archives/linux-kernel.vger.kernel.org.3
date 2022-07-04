Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7342E565C69
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiGDQuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiGDQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:50:01 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF70FF07;
        Mon,  4 Jul 2022 09:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEXmWQ79Jk5Oj9jsV2A79WgW9CmL8xlaIvaHGSOedfezWQh2yILl6rBP0KDfKSpdCpxP7Csjn65+/iazFcmF7MipRWCzS78fKgBNPo15ZEJQOyduKywonDM0jqPc7UsoOK+JtqFck1LSeTDJkZtyfR3fr4y+/9bVlBMyzDdLf4jR+92hHqvpw2n1fOi5DzghCIcMETeWXKsrs4sJCksXVALudzBFVnJLdjx4vOtZrmqiVvBAmAfNXtZJa3uf7hE0IzILQxT2QoEPwLwf4tGqknxnC/ZXlbkylHUN5g49Quufrz/Bb/XyK9E8jx6zG2VGKXBGzvlOdnvEXEuPczVaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YCuT8bFE/pRi0Qfu3R7BnIaaMFTgCTpPgobNw6OCdI=;
 b=TZCqY7qZ7+iAejInmbHvCAvwyltb+Nx2Dj4WR/qsK3fxe4gkRpG4nJDOJ9BcG/yH1H2qkgFh7TY+8l/QduqqHXPFAw1PCotyuUR/qFGkGQT6mLQluRgJX5/MeQoaZQIf27aPnU1pbHDdudTp9O8beFXf3jxIRq6PxOGKIoSmaNKMSHOfLlpaGsrXBGwxzuDsyT7sTeVQHvxQf1QkOYwEQqb55gh/LSU0Wx1rVtPjb+ZS6aLGStPSn8+zZCDYkwocy2yxEaPt4rOPHyT+bcoLhZyeizhOJvLgBXX5Vg3HeKwYrhnyC3UvvMLz4UHbsYuxnsMpH8YQrrPtVSI311gzeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YCuT8bFE/pRi0Qfu3R7BnIaaMFTgCTpPgobNw6OCdI=;
 b=mYj5vOiWap+d0T21KoDNuUCHn4wAHzv0Yo2iS1BrdHSsRofvVF4s50bt5rfioMkAPfLP0IV2ZcZZqmJG/QrVciS/invjauPcKHpCwvOwWK74Trh5hlsTtD875WtXP6F4e2G60nTp0VXsdJ4x67qPDpXVmTGRMqty5cC3VbyfAZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by DB7PR04MB5385.eurprd04.prod.outlook.com (2603:10a6:10:83::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:49:55 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::cc58:11a8:839f:895f]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::cc58:11a8:839f:895f%7]) with mapi id 15.20.5395.017; Mon, 4 Jul 2022
 16:49:55 +0000
Message-ID: <7f562418-f56c-07bb-27b4-d2e54834ef2f@theobroma-systems.com>
Date:   Mon, 4 Jul 2022 18:49:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] iio: accel: mxc4005: report orientation of accelerometer
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220615110240.684744-1-foss+kernel@0leil.net>
 <20220619152726.030f8e27@jic23-huawei>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220619152726.030f8e27@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0601CA0069.eurprd06.prod.outlook.com
 (2603:10a6:206::34) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01804dc5-0378-4697-5149-08da5ddd393c
X-MS-TrafficTypeDiagnostic: DB7PR04MB5385:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wJQsnvxZhLjaG7+r1IYhlhNBJTdfcsIIllUR7eoE9n5sB6l9VqXW2u+oyV3CFw7+4NCHDeBEW240CMmnjRVHdkjUzPjEWVAtkYyoVi7+07MzZ8MhjmlD5PI0elNkDtCSGmU9N/Van/21Ql/TbTLo+hyzXerjZkx4CqA/5bMqReaeccxSADfygUKPh8PUAYPuFO11ygjLYf0zat6WzFT8cTAWIhfWrx2N7ex0b+RokSolH1JtVS4T/Qyj9zRHRSaDQSc05NmihG5E5Oa6l+PvemH8c+xjCxyAA6jO3T2a4YWBKOXCpdkDS4oMVOIfPsuUdJ3f7ZWjD+JKTfrGy1zGS6ukRvNcyIcpHbghMw76Zn7Gn1U6ckQQ1uvtdCniuBsLOhX0bjyuUXnAqr2SHopKfdRuObvAUj+5KB8GtaPi7Inm90cjhV1sqZZvXjtF687WCMMdebRaSdof/Lv5I9EOQOz46XaFFmRbWYf0FPwm0tJ3uaMVZkKWbpJeClHC2fv5HSxeLJu8v1QgEXb7ghRofeI8l8S2BxZD4AwpWDr75/m3iBbsJ621FZcBvv8hWb/fOZiDpbzz5/G25MlocpY8CNyHU+pnaG3n3f1uSWDiYYdU/FxRoi8KbZ0+J3k972JCaxXmmjsu17PHNZ0LzKDbCwxxpXxQwMwvL/X1Pt4V8xCRpEjtMG25ejTRfq45HY2AIXFnjjhh6rnCJkGfg1HFJNhy0SkiUiPvywvMoAI3gp/GIZcIMDZ/6lC9N/+Ni0NG0+43qp04crHLPkgVtrwKQIsKDYYLU7jgrNRggjx1DekMxWr9UK10YI+a05o7UXMN/qPunbPYrYlQgZtqHhnPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(39850400004)(136003)(8936002)(478600001)(2906002)(44832011)(6486002)(36756003)(66476007)(316002)(6506007)(66946007)(110136005)(66556008)(26005)(8676002)(31696002)(6512007)(86362001)(2616005)(31686004)(5660300002)(53546011)(4326008)(186003)(41300700001)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnA0anAxWTJNM1RmV3h5aGRFZTJUKzdSL2NXT2xzNzFIUVN3bGdkZWxZa20y?=
 =?utf-8?B?YmpscDN2QU82UkJQTGtVVUZmUDluQm4vbC9Od3ZyblBtbDVsWjJaODJGRVI3?=
 =?utf-8?B?bDdUV1BzNUxuanJhNFhyN0hFM2hsSE9FL3pWK1Bzd1hYYmpzaDhnN0wwR3pU?=
 =?utf-8?B?K2ovQVU4Tlo4dDIwcUZ4YU1rdE1JSTFCM2grNzZPckhwbEFvQmNyY2E2Qm5l?=
 =?utf-8?B?TlBMbmdnRjB4QklrTEZJNUJCUVZHa3krbWhmUmEycW5uWnVvaXJhVk8raFFk?=
 =?utf-8?B?Rm4weXduQkw4RVN1SGhvYnpzSkNwSGVMUXczVkJtUzM3YnlpMGYvcUF0aEhi?=
 =?utf-8?B?YVNtMnYvdFMrNUtmRExvNHM4M1daeWpoTHZnYzkrYW1QRDArSGtzSTF4RjJD?=
 =?utf-8?B?OFpONnBNQm4rVXFmRzdBdWZ4RXc2NnU0VnF1OUw3RmhYeWFpbkJrbFhmYVJh?=
 =?utf-8?B?TEFlc0RIT3E4aitlWElqRlVIZERvTFBpZzEwbzFkNUVUM3hYRm1xdUw3dkZz?=
 =?utf-8?B?Z1RIZ0toc3F3NzFPOXNzQzlQdnF1RFNheXk2MU1MOFZDVis1b3lVdmZtcW40?=
 =?utf-8?B?d3A1RnNvWjJDSmNwaFVHVms4Z0lDTHRGQkJZYyt1ODd0RzRSSGE4ZW1BaE05?=
 =?utf-8?B?RklvRFdaOGs1NjFRWkp2QkkzblRqTUhTNVo5ZnhTRUV6aldicU5XTTg1elcy?=
 =?utf-8?B?cFduelIwaDI3YnVJa2RNTFBUTTBQcnBURDVhVTdxbmx0RzRFQnBqc0Z6VGds?=
 =?utf-8?B?Wmk0Mmd2R3lSQWtYZFowRWlpM2ZBOGMvRUhNdkFSc1FsczhvMWdETjY3d09J?=
 =?utf-8?B?dk5yc3N2bkxUaGIyU0tlbUZ0c1RrRFhkaGYxcDBjdVg0M2dsWjlhM3VzRjkz?=
 =?utf-8?B?SVdRYjlpQmJzQ2hYeHd2RnNUT1cvdnhQcittU0Q5QXl0WXFGUHpKN0JxaTVy?=
 =?utf-8?B?eHE3alF0WW1RSXpCYTc5V0grSnBlTmQ2ZzFYNkQyZE9heGw3RW0wM1lTNElZ?=
 =?utf-8?B?Z1NkUWtPT3dDM2lTaTEzNi81cHcyNE1vVFlLMU9kT0x6aG95U2F0WTM2VFg0?=
 =?utf-8?B?QjFXUDNQWU5RdDBzYUllMHkwd2hnUS96TGNpSW1VVzZIU3ZSeXdvaUo2RFZ5?=
 =?utf-8?B?eUlJQkNjRTk1WVAyeEJmSkF5bDhvRllVV2lXdk1zWW5QblRMSENBb3VIMGNu?=
 =?utf-8?B?SnRDNFJYTWsyRGpvYTAySStRRUhUNTZLQUdSd3FtaVI1cnk5N3JsMkpSSzVG?=
 =?utf-8?B?NDFhYjVkNkphUDBNaUhYVC91R3pjVWZmMERPTDJ4d3JVRFhXVzNEZFpSVFNZ?=
 =?utf-8?B?RisyQ3VmN2cwTWtIMTdEVytkM1ZSUTBPdXhvb3M0Qm1zUGJHZU1wenRHU01m?=
 =?utf-8?B?MjIwNW4rTW13OW5memZOb2FoYjFjQ1RSd2NMbWNta2FTcWVic3A4RXNIdmNO?=
 =?utf-8?B?dnVyMmNnTU8reEZENlNNQWlKdW0rdnpTaTh0bEVxb0RnRUVxdVVqV3Rtbmgv?=
 =?utf-8?B?Y21lVkxRVUF3T2c3YkhCUUVIRHV6SHV6bmZiMkt0cUZ6SmlqTGF5N0d6TmE4?=
 =?utf-8?B?VjJDYnVIS040bmk3cUFGaWtQU0RkR2Q4Z3FSV1BxbjQwT3dkM1M4UER2SHlY?=
 =?utf-8?B?bnV1cHZ6bE9HditNL3B5dW9oK0kwKytVcUNDV1ZHcXdNcGd4MGJlanhaMUFJ?=
 =?utf-8?B?bG9CUzluRnRIWlkxQ1JsUG1ybWZWQ3dpZTQ2dExEMTBCNWZqSGFaV09ZR21F?=
 =?utf-8?B?VHNDbXkwUlJjM2RCZHBvTzRGYnh3N3FEM0hFS2d2aWxzMU10bzU0cUhyN3dP?=
 =?utf-8?B?bkxJNkxqQ1dFdndicUNBTTJVWCtPdzRudnZKNUtGTVUzZ0RMMCtlTGQ4bWNL?=
 =?utf-8?B?MnJBa1hGaGhQSmtCRko5a3dSQWRRdkEwQmxCSjc4dnpJd203TGFvQjFmZnBN?=
 =?utf-8?B?QUNKTW5CZzMvNy8vdnhrdkxwR1owKzYxd2dkaVNuL2xmbDM5ZlNiczFIdUxa?=
 =?utf-8?B?a1ByUkRWZkp4SmJZc1YwaVBKd3VqdGRCYnRHMkVROStGMGF2NXVYUnpURnVH?=
 =?utf-8?B?aGQwUzlPSVAzZC92ZkpKd2VucTV1cVMwNVhZTmttTlQwRFlRdlJhU3RGMmdT?=
 =?utf-8?B?K3ZmbXdQNzVnbWtlL1U5NVlFNm9pUnlDcUxqTkJsd2FQSENYb1ZBWU1iRW5y?=
 =?utf-8?Q?wPw5MLVCUAyoDQvoL7ZdSWU=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01804dc5-0378-4697-5149-08da5ddd393c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:49:55.6693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cUGMDkuBTqBkno3a0/QPl64/lSO+sbF5yXM8mt8BjpwbJOGg3ma9iBcwX7O9qn8QzaJuWJyhty0nhUYXYNS2uXQEsBFeTxOKv/FxwhYHGW+CsA0R3ndtiCt5tr90Por
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5385
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 6/19/22 16:27, Jonathan Cameron wrote:
> On Wed, 15 Jun 2022 13:02:40 +0200
> Quentin Schulz <foss+kernel@0leil.net> wrote:
> 
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
> Hi Quentin,
> 
> Interesting / horribly ill defined little feature ;)
> 
>> The accelerometer can report precise values for x, y and z accelerations
>> but it can also simply report its orientation on XY plane and Z axis.
>>
>> Since the orientation of the device may be enough information for
>> userspace and allows to avoid expensive fusion algorithms, let's add
>> support for it.
>>
>> The orientation register stores a 2b value for XY plane orientation:
>> between 225° and 315°, returns 0, between 315° and 45°, 1, between 45°
>> and 135°, 2 and between 135° and 225°, 3. We "round" those to 270°,
>> 0°, 90° and 180° degrees.
> 
> Wow. The datasheet description of this very confusing...

I'm relieved I'm not the only one confused by this datasheet :)

> One key thing is we need to be careful of is that tilt (x/y is
> not always available - but rather shows the last, and probably
> now garbage, value)

Being pedantic here, not garbage, but outdated. This register exists so 
that the values aren't garbage (at the cost of being outdated). Except 
this small notion, I agree on the statement.

>>
>> For Z axis, the register bit returns 0 if facing the user, 1 otherwise,
>> which the driver translates to 0° and 180° respectively.
> 
> I assume facing up vs facing down?  User might be lying on their
> back in which case this description doesn't work.  The datasheet

Correct, I was playing with the device while seated, hence the bias. But 
yes, everything is relative to Earth gravity, so face up/down is a 
better description indeed.

> also talks about the case where g lies near the XY plane and hence
> the z axis is horizontal.
> 
> 
>>
>> Those values are proper if the accelerometer is mounted such that the
>> XYZ axes are as follows when the device is facing the user in portrait
>> mode (respecting the right-hand rule):
>>
>>       y
>>       ^
>>       |
>>       |
>>       |
>>       +----------> x
>>      /
>>     /
>>    /
>>   L
>> z
>>
>> Since this information is very basic, imprecise (only 4 values for XY
>> plane and 2 for Z axis) and can be extrapolated from the actual,
>> precise, x, y and z acceleration values, it is not made available
>> through buffers.
>>
>> A change in XY plane or Z axis orientation can also trigger an interrupt
>> but this feature is not added in this commit.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>   drivers/iio/accel/mxc4005.c | 39 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
>> index b3afbf064915..61f24058d239 100644
>> --- a/drivers/iio/accel/mxc4005.c
>> +++ b/drivers/iio/accel/mxc4005.c
>> @@ -20,6 +20,11 @@
>>   #define MXC4005_IRQ_NAME		"mxc4005_event"
>>   #define MXC4005_REGMAP_NAME		"mxc4005_regmap"
>>   
>> +#define MXC4005_REG_TILT_ORIENT		0x01
>> +#define MXC4005_REG_TILT_ORIENT_Z_MASK		BIT(6)
> 
> I think you need to deal with BIT(7) as well.
> 
>> +#define MXC4005_REG_TILT_ORIENT_XY_MASK		GENMASK(5, 4)
>> +#define MXC4005_REG_TILT_ORIENT_XY_SHIFT	4
> 
> Don't define the shift, you can use FIELD_GET(MASK, val)
> 

Wasn't aware of this neat macro, thanks for the heads up.

>> +
>>   #define MXC4005_REG_XOUT_UPPER		0x03
>>   #define MXC4005_REG_XOUT_LOWER		0x04
>>   #define MXC4005_REG_YOUT_UPPER		0x05
>> @@ -96,6 +101,7 @@ static const struct attribute_group mxc4005_attrs_group = {
>>   static bool mxc4005_is_readable_reg(struct device *dev, unsigned int reg)
>>   {
>>   	switch (reg) {
>> +	case MXC4005_REG_TILT_ORIENT:
>>   	case MXC4005_REG_XOUT_UPPER:
>>   	case MXC4005_REG_XOUT_LOWER:
>>   	case MXC4005_REG_YOUT_UPPER:
>> @@ -214,6 +220,28 @@ static int mxc4005_read_raw(struct iio_dev *indio_dev,
>>   	int ret;
>>   
>>   	switch (mask) {
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +		switch (chan->type) {
>> +		case IIO_ROT:
>> +			ret = regmap_read(data->regmap, chan->address, val);
>> +			if (ret < 0) {
>> +				dev_err(data->dev, "failed to read rotation\n");
>> +				return ret;
>> +			}
>> +
>> +			if (chan->channel2 == IIO_MOD_X_AND_Y) {
>> +				*val &= MXC4005_REG_TILT_ORIENT_XY_MASK;
>> +				*val >>= MXC4005_REG_TILT_ORIENT_XY_SHIFT;
> FIELD_GET()
> 
>> +				/* 00 = 270°; 01 = 0°; 10 = 90°; 11 = 180° */
>> +				*val = (360 + (*val - 1) * 90) % 360;
> 
> In event of tilt not being set (BIT (7)) I think you should return an error
> code here.  -EBUSY perhaps? To reflect the fact we don't have valid data.
> 

Difficult to find the appropriate error code to return. It's not 
technically busy, especially if the device stays in that position 
forever, it'll never return a valid value.

>> +			} else {
>> +				*val &= MXC4005_REG_TILT_ORIENT_Z_MASK;
>> +				*val = *val ? 180 : 0;
> Documentation for this is really confusing, as it refers to a circumstance
> when it can be assumed to be horizontal, but then doesn't define it.
> 
> It might be a simple as tilt being set and thus indicating significant
> acceleration due to gravity in the xy plane.
> However, the Z orientation is still updated in that case...
> 

I'm wondering if it's not an exclusive validity of axes. E.g. XY plane 
is valid only when Z is not and vice-versa?

"The vertical/horizontal Z axis
orientation is determined by the same criteria used to determine the 
XY-plane off-axis tilt angle" seems to indicate that the TILT bit 
defines whether the Z axis is vertical or horizontal.

"When the XY plane
has a sufficiently small off-axis tilt angle, XY orientation detection 
is valid (and continues to be updated), and the Z
axis is detected as horizontal" would mean Z is just not usable when XY 
orientation is valid (because Z is horizontal and thus does not have a 
big enough acceleration to be usable).

"When off-axis tilt angle exceeds the
threshold discussed above, the Z axis is detected as either vertical up 
or vertical down, depending on the sign of the
Z axis acceleration output." could be interpreted as "when XY 
orientation is invalid, Z orientation is either vertical up or down".

>> +			}
>> +			return IIO_VAL_INT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>>   	case IIO_CHAN_INFO_RAW:
>>   		switch (chan->type) {
>>   		case IIO_ACCEL:
>> @@ -287,11 +315,22 @@ static const unsigned long mxc4005_scan_masks[] = {
>>   	},							\
>>   }
>>   
>> +#define MXC4005_CHANNEL_ORIENTATION(_axis) {			\
>> +	.type = IIO_ROT,					\
> 
> Hmm.  Should this be rotation or inclination (so referenced
> to gravity).  Inclination is not particularly tightly defined but the
> point is that it is relative to gravity - kind of a special case of
> rot.
> 
> For the adis16209 we handled inclination and rotation.  I think rotation
> in that device corresponds to XY here. (though it's oddly defined for
> X axis, whereas I'm fairly sure it should be Z - as rotation 'about'
> z axis). The Z one here should I think be an inclination because it's not
> about any particular axis.
> 
> We also have angle to confuse matters. In that case intent was 'between'
> two things. Arguably all the uses of rot are as well, just that one of those
> things is gravity or magnetic north.  With hindsight I think we could have
> gotten away with one of them, but hard to tidy up now.
> 

You mentioned the three candidates I had in mind, but none seemed to 
perfectly match (or maybe I'm just confused about the difference between 
the three and just can't make up my mind) so I picked rotation because 
the English term seemed closer to what I think those values represent?

> In conclusion, what you have here I think is best described as
> IIO_ROT about Z axis (the XY one)

I disagree, this would mean that having XY plane parallel to ground and 
rotate the device along the Z axis (so XY plane staying parallel to 
ground) should change the value of this IIO_ROT on Z axis, but it does 
not if I'm not mistaken (I assume because the acceleration on X and Y 
axes are too small because the axes are parallel to the ground).

But that also kind of highlights that IIO_ROT for Z as I've done it in 
the patch probably isn't correct either and inclination would probably 
match best?

I feel like this will be an interesting discussion :)

Cheers,
Quentin
