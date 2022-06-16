Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B3B54E1A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiFPNOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376981AbiFPNON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:14:13 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 06:14:10 PDT
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA21433A38
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:14:10 -0700 (PDT)
Received: from 104.47.14.59_.trendmicro.com (unknown [172.21.19.34])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 6457E102FBE32
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:13:09 +0000 (UTC)
Received: from 104.47.14.59_.trendmicro.com (unknown [172.21.196.58])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 5B54A10000C5A;
        Thu, 16 Jun 2022 13:13:07 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1655385186.217000
X-TM-MAIL-UUID: 1ea404bf-4bda-4b7a-8368-1a4c928dc36b
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (unknown [104.47.14.59])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 354AE100010A0;
        Thu, 16 Jun 2022 13:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEsjoNqbtDJz/hez477bI9sKIZyVLDccs0Sx0A8EinkTkC8zXEGUTOfLzcBcvIL5Xj6KT9waMQIacxOKTil7AXOdDHYNE4QQ6TJiBG5bN7EIKNEXB40D+Z3wz46JHdifk//CbaoRAtdvGY58JaL/DYOVJZ7l9Sk8lBmWCG2MIK+P5w5hcaSf+jw5OEw9oDgeMI8eZmHoVBTsKFr+iZsdVb/QtXtJX7xZHty8NzBYA8GPvOH+CnDzrTs6dhZvf8aIrt0OJD/f02tk3a1/yFz9p8b7Fba/cih7vcJcjZBf1fr6TY4T5gxx6WNtWbIhia4Wjesiy5rW/nMSm21GtkfhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8dxx98kvbQ+XCxejUt0hj1klHQuupHMJ5US9lDZY90=;
 b=dl0yp9Fh5rr+94kLA14zNvgfRuV9gi5ej/m2tfj6oPIEr0E0+o5N6Ll+Pgx/hUYJmG06knG+1GWUXhXS3CYYOvjAnbcg/AXLPfJl/d1rzZFoZOKqoiPxInI6ywNjRNAW7NZOwLqs9O+JRjQ7yDPeD7SR6tG/HaGcB4pQpKTkxBM+F76lqeLE32HDV0AMwiumLl/KE43kCyk37mOEuqMPBqb9nOckOjN0y2yjLVOnrj7i/fkqUHwtkiqomGPefsEdGYeUBrP/1CGYPn57sj8ajbQtSUanOCbFrg5RKodDTuZGjJoYuWB6UGWoLuvDK/qZAUQ54FQ0qDkPSD70el686Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <c72a13b3-d3c9-7502-07fe-ebb76cb0bb3d@opensynergy.com>
Date:   Thu, 16 Jun 2022 15:13:02 +0200
Subject: Re: [PATCH v2 4/4] tools rpmb: add RPBM access tool
Content-Language: en-US
To:     =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     maxim.uvarov@linaro.org, joakim.bech@linaro.org,
        ulf.hansson@linaro.org, ilias.apalodimas@linaro.org,
        arnd@linaro.org, ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
 <20220405093759.1126835-5-alex.bennee@linaro.org>
From:   Harald Mommer <hmo@opensynergy.com>
In-Reply-To: <20220405093759.1126835-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0044.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::19) To DB9PR04MB9627.eurprd04.prod.outlook.com
 (2603:10a6:10:30a::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 172b03f7-0553-4cdb-aa7c-08da4f99f2d2
X-MS-TrafficTypeDiagnostic: DU2PR04MB8759:EE_
X-Microsoft-Antispam-PRVS: <DU2PR04MB87590CB9A575516D70079FDBE5AC9@DU2PR04MB8759.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCv+zWfgtnv9sbPbrIlBLCu3avT0Qn6su63reDMooE83vY/Zl7nGk7VuQ1yXfKVLSyDu27Q5XrRLEsEVmy+sHWVbD2lxotFfSywc+ucNO5t1FGXLDcINr+uxExQH3Wizeq43r3ORDocGfIQJoRGHKHimvN6RGyIi72npJjEPgYynAbHrWLVcNPZCJjY0BcyPsDho8Wadh+OiTIPnHN7IW1m5sphYLRcRFObPP8bvRlqJUy3mkKVoF103NNuvKuVQ0q0fsg/X0qYPvucDtI91L1+GDk7F68bSR9tha8HI4aGm6W59UHkwm2DWIWNRRmPsi3JEx9wdj9oGjacmGNqSddrgpi/rYAqVwpvnO/gF/aWldd5uU7wtRRzxu+SDKNTs6mX2DE0kUsg/yrp4h00zxOLCxAGvEzZHaVQcwIn8BW6V0FnHANc0jcKVOBFyDcL5zrtojslMJqoHaa+swRhen10C1cNx9L84nhRv/vibaiYzizXsPFm/0KF6vtCS5njDeuxgMmNF3hn8/Ka4DmPfpXmhqI60I7++GEyinPwhNJxfKfZwLz27h7cUQQPmbdW4tNCjmWNsy9uKX8SyVnC4ldhoTNj4W8sXGWClKVVmZeBfm8KEqef4Tw0064VGIW+zTZfZGlPYY5LDrLQQO2vTMlKfCddmjH8jHfIFVwnbLcMjsNEc0wSao63n5mIZD/Nmlm4FDz+U4UDuLteTC5AyhCZA50exo6n5azUqmgPBPVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9627.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(2906002)(31686004)(42186006)(316002)(38100700002)(36756003)(83380400001)(15974865002)(66574015)(2616005)(66946007)(66556008)(66476007)(5660300002)(7416002)(8936002)(26005)(508600001)(186003)(53546011)(4326008)(8676002)(31696002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnFBTE42QlprVytiR0xDVG15Y2hJcm1CM0ptbjJwUlREbVRiQ1JhZGtHS0dF?=
 =?utf-8?B?TXRLOVU1WW1VZUphZG5EWkpwOXgzZUoxZlNteEdlWWMwdFpnSnh3T25hdjZN?=
 =?utf-8?B?ZXlmUi91STYveGpRVGRkK1lpZURwOUp2bXlZbDVKRGxIRUJTU00zS0dkVFBQ?=
 =?utf-8?B?Ni9JQ2ZQd1ZvL1ZlWThTcmozUFNCTWVtbGZTUUMzR3FaV0tCbmhERHdjRnZT?=
 =?utf-8?B?MkUrL2QxWDdTa2hwK3FDd2lPUzQxWUZiSFExa0NWNnExSE5jd3cydTRiRERs?=
 =?utf-8?B?OVpqVUdWdUgxVlBjTHdUZC8zUWRxZ3FMTEZlT3VoTGE1NndtRW5KUGpZRU83?=
 =?utf-8?B?Vk0yL1dGTUV4dmhXeXZFMnN6TWx2c0paK2M2SitmVndIN3FhdW1iWC90WHQ3?=
 =?utf-8?B?V04wWUtRUFNDTlYrS1JOTUVxNFVqZGFoREErL1Q5YlFCVlRGa2lLMTV3NURq?=
 =?utf-8?B?R096Q1hOR0FmYmdadEFLMEhzelYzL3oyaEFFenFZdVB6T2l5MjFRL1VOZldl?=
 =?utf-8?B?TVNvdmVNWHhTSVc2dDlDRWJYSUgyM05ibXRpeEwyL3lQRGpoRWRmOW1KMU9z?=
 =?utf-8?B?L21nRkJyQVNOTkNUQ0NJNktPQndiWTZrMStxOUI5VCtRLzdXcFIrbHkxOGpC?=
 =?utf-8?B?ZlovbjFGNFJkT2c4eElLZWRkaDh5QUUxMksvd0R5TFZzdGtSdklqREJ2MmJ6?=
 =?utf-8?B?TXBhemtCeXdHWC9LWUJ6NG56MDBzWEwrem1POGgzSWtuQStEZ3dibS9WVWlt?=
 =?utf-8?B?Q05HRzVlRzdqaDJ6RHJzUy9iYXNWdyt1clI2YVhZdWhOTSt2VlJjOHZBeDhP?=
 =?utf-8?B?aENxY3R4K0lCdno3eXE2WkpOT09lSzFqelB0b0IwUEhIQ05iZHQvRHVLMjda?=
 =?utf-8?B?N1lHRnFETlVBUlZ4cGlTMGVmTFVrM0JsOWx1ZnA5ajdrSWZuemUySkFzVVhl?=
 =?utf-8?B?aGk3WExGS3pZeTIrMm5WVzh2aEYwWmI3Tk0ybXBmcnkzNTlUT0trQ0N3em5W?=
 =?utf-8?B?YUFvOURiMkJCMWtwa0F1WDNINkVwNTVicEh2M2dOT3RzRW41bFY2cUh5dnZP?=
 =?utf-8?B?ejIrUFc3M3VpRlV4ayszODEwZG5KM0ZMUWxIczlyUFdjQldHRWJDVUZmTDJn?=
 =?utf-8?B?S3pDNnNFc1ZrU1BLYkkzRXpOREdnaUFnOFJvSWhCU2pyQmdTU3NINElMWmhh?=
 =?utf-8?B?ZVgwOEl1ajR3ZEtRS1RtcWJpQW9GSG1mZ3lIdkhTQkNYaXJ3REtHVlZPNEU3?=
 =?utf-8?B?UCt4Y3BkZ2FMQnM0RWRZWXVmQlRSUUxhaVd5SkZQSjBDc0dJU3JXTHoxUnho?=
 =?utf-8?B?Wk1LWGNGUDE0UHVGR0hVODk5Wlk1U2NSR09HOU45dGVMNklyZ01JZ3VVekwy?=
 =?utf-8?B?UjRsSnFJcDlhTjFmSTYwMWZpYkMvVjJhTE9NN3ZoQUovbnovcHJxbkc4ai9a?=
 =?utf-8?B?Nm0wTVBJQnY5bUhOUmc3V3pVczM2SHpHUmtKRnlMNWxUSmhpbno5MTlpbTR1?=
 =?utf-8?B?THo3Z3JaTit2eVRQQnhjSUxDTjNUZVdoeDVydCtISWVIZWdUUmdqZXl0eGJP?=
 =?utf-8?B?bHdTZzl2N1NCM2pxQ1l5VHlKUlJ3UW4yZTcrcSsxYk1halZvVGVFTjJqc2xU?=
 =?utf-8?B?U0JHYWs4L2J6STNkYzJEb0l4c2RqdEEyOWFydGxjQ2lQM1ZpeTVjNDZGemlm?=
 =?utf-8?B?Si9rVWI1UUhsTCtNcDVkWkVwN1dZQWp4VlkzUHVjWHFLVjhhU2dKRVRNTVZ5?=
 =?utf-8?B?ekdHWFBYNmw4RTdieVYwaDhTU2hIVitZeTB1cXlXVnBhVmlBM2JXKzhsYTNk?=
 =?utf-8?B?dDlBWHM5TVUvbEhucUlpZENtTTliT0JlWXpDNm83V29HNytRQUZ4bGpHbkps?=
 =?utf-8?B?K1J1NUxaWW1zbUQ0UCtsSmFzWGFtUVJ4NE4ydzFJNlRFV1BSZWs3SWpsQzI4?=
 =?utf-8?B?S0lScG5sdDhpdEJKazl5bkdIRXY1S25XRzgyYUZ5aDRvUlVZQWt3a1h3Kysr?=
 =?utf-8?B?aEMvSkYrTi9pL2pGK1JQSEVSUHZkR003OXBsdXllaGo5cEttWFZlQ0xjeWZI?=
 =?utf-8?B?R0lwTkJSeHdpbWF0eUY5dVZoSEpDS1VTeDd0ZW1TMHVrT1l2T2UxUGlYQjJU?=
 =?utf-8?B?WEJGeEVZM1FSUG9OS05UUjdBZjF3akI2VkpSbmhWY1J4cjR5UXNCOVZjTk5h?=
 =?utf-8?B?cUR2MU11UHpRdldGU3NxcGIybi9LNk5oTjF5aE95Y0dFV0FyVm4xMWs4ZExq?=
 =?utf-8?B?OEY1a2JWc1BHMHgzQmtCZzhoNWxJakJFd0tMUkFGVTJVTS9xeUJ4QlEwYlVW?=
 =?utf-8?B?c2g4M3NtRG5FaGpaWGRzaXAwSUtlS2JlMjY3S3RuWXg3VHpCNUU4Zz09?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172b03f7-0553-4cdb-aa7c-08da4f99f2d2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9627.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 13:13:05.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3m3dGi75+Us8/DvGwgjJnmpHPnYP3OYwWmNK++dywi0Zke2c+WtqmT9TTPJM88fb7UBfr1hivzNG0gAia5NCXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759
X-TM-AS-ERS: 104.47.14.59-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1004-26958.007
X-TMASE-Result: 10--26.276000-4.000000
X-TMASE-MatchedRID: Jm7Yxmmj9On/9O/B1c/Qy65i3jK3KDOoC/ExpXrHizyOD/YpR7I+IoPc
        XuILVCbaT+Ssx+cLRQOrlQnbB6G4NwzMLoYOQzD/U+SCBkL7836OQOsE4nDCdEBJWZqYnN7avjN
        9OkaN1trzgfRAkJS4G34oUWpcKNWpGU9P+A3Ax1VIK2DGByysypki3iIBA3o/UV7F0kclfoKB97
        pzpMZ9Yb5wpZVCbFHLGf8/5qsa+aR/4m4yZXmXb3V7tdtvoiba4SkIdSwphga6pZ/o2Hu2YcvQs
        fAE10p3PhG3C4bJ9uelztAS7WpJHPnU8bWnyOtNVV4ZZmbE3YzQxDD776KHL44sT3VHmSnEwisn
        IbO8h0PhJoKhz+mVIpc1ZBri4zqQtfKsnmadsBx+njGZQKtC7ypykp1AmBYaF2J2qC/34DsgaVH
        62KJz2wx+wXfgJ2JXPfRUVBjvSwtMnMwEhENCNHAnLUK6q8ZUDVuL2vYqrd4bWHktq2pLiYVYrc
        Ipy8T8/XVOP8FVfqJftuJwrFEhTbew1twePJJB3QfwsVk0Ubv+efAnnZBiL6nKAIYoU8L4F5iXm
        5LZACA=
X-TMASE-XGENCLOUD: cec9833c-9309-4bad-8708-4decebf359ac-0-0-200-0
X-TM-Deliver-Signature: 940ACE03D6EF652DAF1FB987B2A911AB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1655385187;
        bh=rGGj5KwhUAKraeSfQ6WqjHJfUhEtPuAp0E019tCI2wE=; l=5490;
        h=Date:To:From;
        b=lTA6sD6nFivxDl3lFIXdsp7oZG9mdce/zbYYoUojMC49opzCnUXXe0X0vwmt5UsR3
         8C6l8wbDQPM+q7BW4IIAIPF6XKIM0IobAt8VYhF7Sd6P7DPMexdAQtAoxlRgsFOyBl
         jH8IDDg0YDwtRoAP2NXlzxpayxeNjjfdy35ni62b2nHyij1twMUS/kK4+DoFVVrNqh
         fpkHNEfQIX6Y/77CRgfpVVotedYAYNvdKalVb5Ar67hMaN9+Ukt93D1wRcu1LALe5G
         1t+xBFPkf9a/Ly1AZOfK0g2EEZE0MGD/EXLfPFvG5SbsadIpZN0YrGy72kEypMsJli
         8FwphdLgbsj0w==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 05.04.22 11:37, Alex Bennée wrote:
> +/*
> + * Utility functions
> + */
> +static int open_dev_file(const char *devfile, struct rpmb_ioc_cap_cmd *cap)
> +{
> ...
> +	rpmb_dbg("RPMB rpmb_target = %d\n", cap->target);
> +	rpmb_dbg("RPMB capacity    = %d\n", cap->capacity);
> +	rpmb_dbg("RPMB block_size  = %d\n", cap->block_size);
> +	rpmb_dbg("RPMB wr_cnt_max  = %d\n", cap->wr_cnt_max);
> +	rpmb_dbg("RPMB rd_cnt_max  = %d\n", cap->rd_cnt_max);
> +	rpmb_dbg("RPMB auth_method = %d\n", cap->auth_method);

The previously present device_type has already gone. Do we loose an 
opportunity to inform the user about anything which may not be virtio 
RPMB in the future or is this intentional? A new device type VIRTIO_RPMB 
instead and keeping the door open for UFS, NVMe, eMMC etc.?

And if the removal was intentional: rpmb_target, block_size, 
auth_method: Still needed and if so for what is it good for?

> ...
> +}
> +
> +static struct virtio_rpmb_frame * vrpmb_alloc_frames(int n)
> +{
> +	struct virtio_rpmb_frame *frames;
> +
> +	frames = calloc(n, sizeof(struct virtio_rpmb_frame));
> +	if (frames)
> +		memset(frames, 0, n *  sizeof(struct virtio_rpmb_frame));
Very minor: calloc() already zeroes.
> +	return frames;
> +}
> +

/*
+ * To read blocks we receive a bunch of frames from the vrpmb device
+ * which we need to validate and extract the actual data into
+ * requested buffer.
+ */
+static int vrpmb_read_blocks(int dev_fd, void *key, int addr, int count, void *data, int len)
+{
+...
+	ret = ioctl(dev_fd, RPMB_IOC_RBLOCKS_CMD, &cmd);
+	if (ret < 0) {
+		rpmb_err("rblocks ioctl failure %d: %s.\n", ret,
+			 strerror(errno));
+		goto out;
+	}

The (older) rpmb tool always puzzles me with complaining about the mismatch MAC when there was also a result != VIRTIO_RPMB_RES_OK.
I guess the ioctl() returns 0 if the ioctl() as such succeeded but there is an error code indicated in the frame.
Consider adding to print the result if it indicated a problem.

I can remember the old tool used the result of the last frame for this purpose which was probably not a good choice, not sure why this was that way, probably the first frame would be a better choice.

+	for (i = 0; i < count; i++) {
+		struct virtio_rpmb_frame *f = &frames[i];
+
+		vrpmb_dump_frame("block data", f);
+
+		if (key) {
+			ret = vrpmb_check_mac(key, f, 1);
+			if (ret) {
+				rpmb_err("%s: check mac error frame %d/%d\n", __func__, i, ret);
+				break;
+			}
+		}
+
+		memcpy(data, &f->data, RPMB_BLOCK_SIZE);
+		data += RPMB_BLOCK_SIZE;
+	}
+	ret = 0;
+
+ out:
+	free(frames);
+	return ret;
+}
+
+
+static void *read_key(const char *path)
+{
+	int key_fd = open_rd_file(path, "key file");
+	void *key;
+
+	if (key_fd < 0)
+		return NULL;
+
+	key = malloc(RPMB_KEY_SIZE);

Very minor: There's not a single free() for key in the code. Plays no 
role here as the program runs only for a fraction of a second, just saw 
it. You are making your life harder as necessary by using dynamic memory 
when it can be avoided, all those NULL pointer checks and the free(s) 
which have to be done...
> +
> +	if (!key) {
> +		rpmb_err("out of memory for key\n");
> +		return NULL;
> +	}
> +
> +	if (read(key_fd, key, RPMB_KEY_SIZE) != RPMB_KEY_SIZE) {
> +		rpmb_err("couldn't read key (%s)\n", strerror(errno));
> +		return NULL;
> +	}
> +
> +	close(key_fd);
> +	return key;
> +}
> +
>
> +
> +static const struct rpmb_cmd cmds[] = {
> +	{
> +		"get-info",
> +		op_get_info,
> +		"<RPMB_DEVICE>",
> +		"    Get RPMB device info\n",
> +	},
> +	{
> +		"program-key",
> +		op_rpmb_program_key,
> +		"<RPMB_DEVICE> <KEYFILE>",
> +		"    Program authentication KEYFILE\n"
> +		"    NOTE: This is a one-time programmable irreversible change.\n",
> +	},
> +	{
> +		"write-counter",
> +		op_rpmb_get_write_counter,
> +		"<RPMB_DEVICE>",
> +		"    Rertrive write counter value from the <RPMB_DEVICE> to stdout.\n"

Optional parameter explanation [KEYFILE] got lost in write-counter.

> +	},
> +	{
> +		"write-blocks",
> +		op_rpmb_write_blocks,
> +		"<RPMB_DEVICE> <address> <block_count> <DATA_FILE> <KEYID>",
> +		"    <block count> of 256 bytes will be written from the DATA_FILE\n"
> +		"    to the <RPMB_DEVICE> at block offset <address>.\n"
> +		"    When DATA_FILE is -, read from standard input.\n",
Puzzling naming change. The KEYID is indeed the <KEYFILE>.
> +	},
> +	{
> +		"read-blocks",
> +		op_rpmb_read_blocks,
> +		"<RPMB_DEVICE> <address> <blocks count> <OUTPUT_FILE>",
> +		"    <block count> of 256 bytes will be read from <RPMB_DEVICE>\n"
> +		"    to the OUTPUT_FILE\n"
> +		"    When OUTPUT_FILE is -, write to standard output\n",

Here also the optional parameter explanation [KEYFILE] got lost in 
read-blocks.

For people not knowing the tool trying to get into RPMB a complete and 
consistent help is helpful I can still remember when I was in the 
situation to understand more playing around with the (older) tool.

> +	},
> +
> +	{ NULL, NULL, NULL, NULL }
> +};

-- 
Dipl.-Ing. Harald Mommer
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone:  +49 (30) 60 98 540-0 <== Zentrale
Fax:    +49 (30) 60 98 540-99
E-Mail: harald.mommer@opensynergy.com

www.opensynergy.com

Handelsregister: Amtsgericht Charlottenburg, HRB 108616B
Geschäftsführer/Managing Director: Regis Adjamah

