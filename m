Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE2B4D44D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbiCJKlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiCJKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:41:34 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60117.outbound.protection.outlook.com [40.107.6.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67141139125
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:40:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB2+Faa8fjF4N0ojj0f1EaQ2a64Fx0tBYzw35RZ8ImTXYUzEoAkCUR0GdDu3+EZ2Jlyb83ScXdqEXryhVYkXz3WQY2HBvl6kwzp27CMgbH9ApFddYdieXo02pENSV2HqduCMxC7n/5WjrzzUOpBxNBqVKsYuvkAH7hAVbo7IlcKkd1g98yyoUyjU8WMkjW23rhl+Wl36vyPWz/fFKZbjK/3YIrct0nddwwQD6sToFoyFG7KvmQpSioU2KUGQpLPMdZbx5oa41y84OroKmINP9TOmlqBIk2qGpuCedLr9dRWCzILDHiaAnYI0Au7UzAD2NxEQ76J04kMgXkcT94mA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f1Eyz1kcWVpDp6KBYaE9TMkU8itqqeZ1gDWRpm2yJo=;
 b=RdIsnouUU9OUWBMl3Wb+psJgnhc0g3PTko8I57wUPdqWSviHq2LbO9qatlNDgZAcKW8a78tJw7CylllCBus1nN+DrfQMomovUXjxQWBGCfPHJoR+wS9IJ2wkKHVAb+V7+HtcjMd0vFFJFAq/DZS16PZw3liDGwygQIgOdgnjOW39WTwYPzl778o4S4Rmc+L2U4G8ko5PkiUQO3iIxkl25vD6CCP3tg1NKeBFlaR0FrBeNICtjl96mjmz3WipNZ4Au7zP1/ZJuwFiwsB7HkCtzBBgtG1oBEeXBT5stcLO2luLZ5NmchZ/WZEm/646Mi1EDw5ZEapBIzzYh3nzNa0zag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f1Eyz1kcWVpDp6KBYaE9TMkU8itqqeZ1gDWRpm2yJo=;
 b=lZZfgnVYN2dY0mCb2aN9aYsFTdqiLFnhSlnzMRFTZuGWoWSymZ8ibXipmkNXmmy1P00IWCI1/Lz9kA5LvXbPPUbcJYa14trnSs2Fke5hUF5y4UGSFCssh1UFhfCBPzERDCpdL3R73lOKutNknXUoP3mAEMya1Qbg7PCCn1MiTUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB7PR02MB4364.eurprd02.prod.outlook.com (2603:10a6:10:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 10:40:27 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0%4]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 10:40:27 +0000
Message-ID: <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
Date:   Thu, 10 Mar 2022 11:40:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: en-US
From:   Peter Rosin <peda@axentia.se>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Tudor.Ambarus@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Daniels Umanovskis <du@axentia.se>,
        Patrice Vilchez <patrice.vilchez@microchip.com>,
        Cristian Birsan <Cristian.Birsan@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <69bb004f-0bb4-ec56-479c-5deab0ece00f@axentia.se>
 <CAGETcx8Bppn1y3Hffp2N_DPcJA6YyMEv1EFDTa1e1zOrkxbxzw@mail.gmail.com>
 <f91c6f22-67a4-076d-d86d-6be1d14bc18a@axentia.se>
 <7edb467a-c8b4-fe29-9947-f71c655caa9f@axentia.se>
 <8484ce66-639c-03f5-c5db-3574ea26690c@microchip.com>
 <075a196f-79c2-0d58-15f9-ad5e33e2306b@axentia.se>
 <3beb80ad-d6f8-8c6a-e17d-e40a644bba07@microchip.com>
 <e47c155a-f25d-11b3-3339-b2bf71b886ce@microchip.com>
 <9e24034e-f586-a721-9031-179601a69abb@axentia.se>
 <7214ea3d-1445-c0fb-2620-cdc3d6167bcc@axentia.se>
 <b5c57978-212f-55c4-2f0b-b38a8f157ca3@microchip.com>
 <a024180a-493c-af20-0910-da30dd5fe364@axentia.se>
 <6d9561a4-39e4-3dbe-5fe2-c6f88ee2a4c6@axentia.se>
 <ed24a281-1790-8e24-5f5a-25b66527044b@microchip.com>
 <d563c7ba-6431-2639-9f2a-2e2c6788e625@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0102CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::32) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bf33936-9625-4f83-f9cc-08da028263b1
X-MS-TrafficTypeDiagnostic: DB7PR02MB4364:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB4364CDF35E317E2922C4BAF6BC0B9@DB7PR02MB4364.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utduDFV+OJ4o89VFEyRcpJc7RoWCB+dBa1YXgLP1uHvzOJXRofqS7DL8/msp814dnur9bpFC1MNXvbDmVXWhSj3awGvE9muBxjOiBRTh2/VsNkoAmLHQf8MblsFbEpWYaFM/pRsYec5DI0mc1B1mBL3Vu9kHFOJ1ROtmnaQveAerQNM6okzziibDmKhyW27pMBeO8Yxk9KBOoPeR/9EUhl3p/wZKowlvu5LvKhNPLNjI3ofnoPzPizvxUIcFzmXu8xEAzhbU9oxsZ8q+K3wQpRHKIpxKpg7pF4VTPt0lwt/6Zl3cbNbUQRfTu2W55P5N8SO48P8CuQOO7M4CVX1VKbwqZp5BoAFWxrm1Tf46/m4DvTDlCHOyhkQmwz9VRkwlyZD0KeGeF7ewRQFNBKD6aqvGxi/RKilucmCqekidzwjDaVmNSH13ZMwCOVkmay7VmnahgwPDpHUMtFaADnJmyRnZyEzoi83vNUnMJ3iMG5wby82K4LRCUHVA4rJMaNX97LTJrFJecCEX6nhGXSFU+KD9eC6/Wc7S1ZDaJZTLidIHOJyjTVuH1UE6vh5bnwsGH2u9fP7WUrNijyc9H2Jlc0nwVznhBhaJ84nqmxe7BCY21INaAfwWDFacmAFwymXaxxWJwaMKl4j6X1XyIVIvr8u6vTRo27sxZbGPDUalQgLFymC7gtKT7UZ+pmfyC+eGiiEFx7brnzxddCfEu8fGuNSvJFwOSinOhJB9rH9+pEF8nhIRtxB0DXti3ITH0RQFIEANyjoKSiu64Qhb6LoH3KP9Pk99MH1tiSRszKnrIdksnwZR/uMlJdCRVKe5vh1G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(346002)(396003)(376002)(366004)(136003)(6512007)(36916002)(186003)(8936002)(53546011)(508600001)(6666004)(6506007)(26005)(2616005)(38100700002)(83380400001)(7416002)(4326008)(5660300002)(8676002)(66946007)(66476007)(66556008)(31686004)(36756003)(2906002)(54906003)(110136005)(6486002)(966005)(86362001)(31696002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K29YL0xBTG00WnUvMDVzK2dJcEE1L3NORXAzVUNTd21FU3pNN1dvdTNsTjZr?=
 =?utf-8?B?Ry9heThTYVZVdHZINGMzeE1IUzVrTHdvZy9Jc1NyQk5tNEY3dkFYS0JzZ0tB?=
 =?utf-8?B?VkNQSUR1M01YVTk1dTVkTjBlMWpjc2JaUmJ0UlVOYVAwZUM1TzIvNFVTUExr?=
 =?utf-8?B?L3ZMTS9aZkllR2ZPdTh1UThvRmNxY2dqWHBsTm9rQm4rUFZsMjlLVlpqRkxz?=
 =?utf-8?B?Qkt0K0k1a0tubDJ1VTdUdlBKUkJ3Q2x6R1Y2UGl0WWlpMjRLU3ZPWE9lY3RE?=
 =?utf-8?B?WVhkYkxPeHI4TGp4V0I1NXdvN3BadGhyRkZVdkdqQ3Z0THlzY0hObkxkQ2VR?=
 =?utf-8?B?Vyt3Y2c0enY5ZzJTc2taY2lDWlp5Nk5TR0QvUUd1Wkw4S3pDRXdhNG5MNzVX?=
 =?utf-8?B?aHdQby9OaW1TWENZbURHOVZQVDBteVRCRUtGV29rZzBXbmFQY2RpZUxNWEFi?=
 =?utf-8?B?bEl6TXdTRVhaaG1SNVlJcjFZTStNVmVTVmhWR0pVano3eG1INkVONmZmem9j?=
 =?utf-8?B?UzlVV0tYeEpEdHY3Qy8zWmZ2OHlZUDBhd21CZm4zVnhLa1Z0c1pKakV5SzZi?=
 =?utf-8?B?MW15VklLUzNkNFlJTlpWdHhIdmtMUEtvMDhVSWFkTThoTkFrR3JOdW1Ib1Zv?=
 =?utf-8?B?SEpVMk10a2RqZG1RcEdTdzFOSzJPYWl1dURoNnJhaTdyWUpJTzdWK0lkUk5z?=
 =?utf-8?B?bmlQWXpna1NpNXFpZ2J4QWlTQ0tHS2w0TUMrWHQrRlFEQWMyWXZ2VGhaaTFi?=
 =?utf-8?B?RnlNcE8wWi8zdkw4b01Jc1ZNeTJSam41ckRmakVSQ0VPTUVSbDFQZm55UDVX?=
 =?utf-8?B?ZjBaU1NjZHpzd1M5V25HeG1Ba0NaMlF2TGxZYUJFbVYrdjZwWEtycTM1eVVw?=
 =?utf-8?B?Tk43OWNpT1FmeTBMRGphSzAxcm44VnVJWnJ6Tjkwb2h6NHVYZU9SZ3BWZlRO?=
 =?utf-8?B?TnhITUU0SGlaakNhNzhYNElzYm1VOFZ6L24xN1lBUEdpUGNOalc3UzRSUGgx?=
 =?utf-8?B?Tlh0QUNNWGs0NXNxbUlUbklKT3dYemJFbUw5QnBWTGZ6RnYxTmN1RXFaYTNY?=
 =?utf-8?B?YTRET3FCSXFVeG1ybTVhU2NJRHFuSmFXak5INy9PcmNnTGZVbER5UzMzdzNa?=
 =?utf-8?B?M0VxR05mYWZDZWlublJldjFNSnRHUUVjdFJZbE1oTFJ6OUI2MzZqdDBuUkJS?=
 =?utf-8?B?RkcyU1JxczNNb2Z1dzdCM2lWVTNhS2tEc09ETmIrZkFnT3RQNzNyMlkyY1J0?=
 =?utf-8?B?UXpPMndWamhnM2xDS05WVjBJeFRaWHpkZGllMW1XVHFjNlZ6dFBBQ2gxckUx?=
 =?utf-8?B?azBIaHlPQk0ycEpQejJIZVYxSmFxWkxUWU1HVDFIVkFaeHJqWW4xMFRRRTVm?=
 =?utf-8?B?MGQ3WGh5MjlQVFJEQ0VoV1NpSVB1cGx3T0xNRXlsaGs4R0FLWHZMVDZLZWgy?=
 =?utf-8?B?UEdtd1owbTBlbzJ0ZmR5N2hTenFiWlZOd3BjQUw5djVaTXhhTEhoYjRlMkFR?=
 =?utf-8?B?NkFBUm9PMVpKRWpGTWVEVHVYUlY1eDlrSVRocWtmYlhqNklobTlBbllYMXRm?=
 =?utf-8?B?Sm1wZUg2VWFzRnZNSHg0R3VGb2tERStVbVFCQS9lMVc2cktSdi9sMWhCTVp3?=
 =?utf-8?B?K01VZkMyK1diQUZpS25WdjRrVXFYb3R2MEh0TTl2cFJsaGFvQXIvWE5TMndk?=
 =?utf-8?B?a0pWUnM2MEtXd3JWTFZ3T2lGTmhoTE5tQjRkNjErbEJpQnUyRWpjM28xSkpI?=
 =?utf-8?B?ZGRUdDhLTi9nUnB6Zy9HSUlQcllwSzhvQk9NbkVGSnZSUzRucnk2eDc2c0Ft?=
 =?utf-8?B?aUxNUTFlMVVYYVVwclJWM3NkdnRXanI4VDRlcEpZY2JZNkcrcUV5S2pzQ3NP?=
 =?utf-8?B?S2JFZHZvSEFIYm02bDBxaHRHd0Q1Mm03SG94K2diaDVmMGJvK2ZCMWo1V0V2?=
 =?utf-8?B?czVMTWJHNXB3eGRnZUMwNzA0VlQxTm5nY2xRVFlLaG82a1N1WG0rNmF6SXdz?=
 =?utf-8?B?Q1lPZ3ZBU2FjM3BDbXpEb0QwaFdkM1lvV25ZTDhVK2lsZnN6VHRoaFBSL1Jt?=
 =?utf-8?B?ZGFUeHgyeFI2b2ZWbEsyN0t5azBqb243RTR4TnIvTVJaVGNzK0NVeitkZEpL?=
 =?utf-8?Q?bz6w=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf33936-9625-4f83-f9cc-08da028263b1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 10:40:26.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Et4lL01To1EKvGpwcbVn9cIHLmn4CV0fMmj3bqE5guPC4bkZBuGhKmVw/CPxcdhm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4364
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-10 10:58, Peter Rosin wrote:
> [bringing this threadlet back to the lists, hope that's ok]
> 
> On 2022-03-10 09:27, Nicolas Ferre wrote:
>>  From that article:
>> https://lwn.net/Articles/885941/
>>
>> I read:
>> 
>> "Koschel included a patch fixing a bug in the USB subsystem where the 
>> iterator passed to this macro was used after the exit from the macro, 
>> which is a dangerous thing to do. Depending on what happens within the 
>> list, the contents of that iterator could be something surprising, even 
>> in the absence of speculative execution. Koschel fixed the problem by 
>> reworking the code in question to stop using the iterator after the loop. "
>>
>> USB subsystem, "struct list_head *next, *prev;"... Some keywords present 
>> there... worth a try?
>>
>> Regards,
>>    Nicolas
> 
> gr_udc.c is not built with the config that is in use, which is sad because
> it looked like a good candidate.

at91_usba_udc.c, which is included, has the same pattern. But alas, doing
the equivalent patch there does not fix things either. I.e. (whitespace
damaged)

--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -863,6 +863,7 @@ static int usba_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
        struct usba_request *req;
        unsigned long flags;
        u32 status;
+       bool found = false;

        DBG(DBG_GADGET | DBG_QUEUE, "ep_dequeue: %s, req %p\n",
                        ep->ep.name, _req);
@@ -870,11 +871,13 @@ static int usba_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
        spin_lock_irqsave(&udc->lock, flags);

        list_for_each_entry(req, &ep->queue, queue) {
-               if (&req->req == _req)
+               if (&req->req == _req) {
+                       found = true;
                        break;
+               }
        }

-       if (&req->req != _req) {
+       if (!found) {
                spin_unlock_irqrestore(&udc->lock, flags);
                return -EINVAL;
        }

The test started out with 3 good hashes though, so I got my hopes up. But
no, it's about the same failure rate as usual. I have the feeling that I
will never again trust a single sha256sum...

Cheers,
Peter
