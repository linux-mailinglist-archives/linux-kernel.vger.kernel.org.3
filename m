Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C8258E5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiHJD5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiHJD42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:56:28 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777C514012;
        Tue,  9 Aug 2022 20:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Erz9nBe2CJ4UCkVuh3gNrxLw+f0jiB3w66F1UfN7yV+8G0o/tK8hGIcong2UQ3g9+xzIrfUdiFYfLjJNoIs849sQJUE/N4kBzOxHNLcAqAdoys8SrXqsMAG7cXeh1VpMa6SVAGHtByq6cD94CiZmSF3GO9bK/qbXQhgnoW3qD0sDlYBsgTc3RWbrQckVsKl5txGygZRi2kVkAGasBEW1pIb78g10GPWP+FqYxBySkNBjDYc+UmoqIlsrEXHx1zNpIW0Celd/EBuiab1kNmrYKUlzfZ2g0qlJcaPL1jDvppm5ipehPe920/CKG6hxTYiV0NqvwpndEmS5wXUgmKwMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j8rPeo3V9dc4CAzyldHLMgdliZ2+EXNA8FukHZDzzM=;
 b=Iwmpjh2Ime8xujlg1gMze50Oj8wxRbC9QMZm470TD44Mf4Jadc7OYxU6reuNR8L81qTB+v3YjBfOgI6+uzUUs3DBq911Rw6wfw+dXT7G6JpzSIap0W+OkLawSU1+zW8+2hLdwV/Iu8Gl1fFsz9164th+ybq/d4iFPDlPy+Y64rWHZ/1OScbDVlkty7+xjEyt4xrrUqxpfm4jKE7q0kZtWf0/5AwC/tH3vUmhBPX6n1IGVu87SfyG3DkFARkzl7cdzhSRcvdyi/DrVxtWMk4P82XqMsRtIP2TDyK1AEWMicQC3xXnDr6mvS8rEMiAeIyX0q9pxjULa+rJn5Ln1m/tIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ftdichip.com; dmarc=pass action=none header.from=ftdichip.com;
 dkim=pass header.d=ftdichip.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ftdichip.com;
Received: from SG2PR01MB2886.apcprd01.prod.exchangelabs.com
 (2603:1096:4:30::18) by HK0PR01MB3460.apcprd01.prod.exchangelabs.com
 (2603:1096:203:ba::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Wed, 10 Aug
 2022 03:56:15 +0000
Received: from SG2PR01MB2886.apcprd01.prod.exchangelabs.com
 ([fe80::e9fc:d5ca:db1a:9b4f]) by SG2PR01MB2886.apcprd01.prod.exchangelabs.com
 ([fe80::e9fc:d5ca:db1a:9b4f%7]) with mapi id 15.20.5504.021; Wed, 10 Aug 2022
 03:56:15 +0000
Message-ID: <1b94fa11-ee73-6fce-be1c-c113329c27b8@ftdichip.com>
Date:   Wed, 10 Aug 2022 11:55:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v1] USB: serial: ftdi_sio: add IDs for NEW FTDI Products
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, malliamireddy009@gmail.com,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com
References: <ac28f2c5eba23a645b3b9299c224f2755a233eef.1658385786.git.mallikarjuna.reddy@ftdichip.com>
 <Yu0DgKWYqGim7y3E@hovoldconsulting.com>
Content-Language: en-US
From:   "Amireddy Mallikarjuna Reddy (FTDI-SG)" 
        <Mallikarjuna.reddy@ftdichip.com>
In-Reply-To: <Yu0DgKWYqGim7y3E@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: AVG (VPS 220809-6, 8/9/2022), Outbound message
X-Antivirus-Status: Clean
X-ClientProxiedBy: LO4P265CA0087.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::18) To SG2PR01MB2886.apcprd01.prod.exchangelabs.com
 (2603:1096:4:30::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0751c7e7-5248-45e5-6086-08da7a8445c6
X-MS-TrafficTypeDiagnostic: HK0PR01MB3460:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ck0Uv9Adz0Oyw6W4LaUl3qfydPRBAVV1aJC8LHBM4DSFxR7TJk/9p3lmI3An8wu4jiNpjtILIoaOFNp2GueJsA2XuggywCIpxIIAZbewU4f2N5WtAJUlK6dYHa2KMgw+AntyB98p4Wr7mmXjdhx9zOhLHnh10LtEnGZ+nXu+ovQBm25KGYh8ojBrNnK6nG6h62X7ueOhJn92b6CUUjGEIu4xnKtt9wMnOM7aGnbPFu55Q/+y9fCvMZ50mwxGdRTtEWQO5ua7F9xZ+c3lgXjdYnZb4xp/yfx/rztr6MbvCCJQ82i2B3fLVuVkNt7vTiDwPKPkQv3DTh66dE6f0OJPUD8il9bsIxyVjYZS3cXIslEXRNWVg1+jj5ZtDDA7vNN7EpQtUPA3BYdIjsW5uZId3d6Fie4Ze/GNKogz0wHWYxa+BIR/8dYat2nyaFMLMTTCll4qtEXuOsuf7ti3017+RZRn09v34kclHhIDfnouXmzDLVvNWQb/lIlXP68+4JTzKLpYWBX3PB1OYu5axH+ElIqVEfiPI7DqUZoYpwCRm0GCaltPLiorGgwH8upDif22D6Y1Qae/0R2eIz7ljnpT04H3Lk6oxdnQWJkb5BFWI2qvQCDE021blLK142i5g4pkHDmfiXRsySc0VEfXRV9Gzs5yjODISbfjnUFD++/yf2td1nnnfrXjtf4JYRiTBiLhrwsdp/+raz8hg0yyoy6s1Uu4ra90+RX5l34f3FJVErs2V1DI/0yI5ngEEOuWU8E6FLEegEVol4u3UNjHMlzdLDsiB9FpWf5d6KGNAADWlfnI8F2aTxTo6rokiPXLifUzHRvuHRZbslE24R0faYdbdxL1ZRn6xGTW7Niq/FuTW0xRG9ASjYvArP6KsIKErb7W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR01MB2886.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(396003)(366004)(136003)(376002)(346002)(36756003)(86362001)(31696002)(31686004)(53546011)(6506007)(6512007)(26005)(6666004)(83380400001)(52116002)(2616005)(186003)(107886003)(8676002)(4744005)(966005)(478600001)(316002)(6486002)(41300700001)(2906002)(4326008)(66476007)(38100700002)(38350700002)(5660300002)(66556008)(66946007)(8936002)(6916009)(231253002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEtGMmVzREtGcVEyUXRHWjBoWlZzaW1pbmVEbzhMTzQ0VmViNGt2YjNZKzNZ?=
 =?utf-8?B?aVhjT0t1N0orU0Z1M0ZZMmZFZEFvWC9WeHliVGVHK2RoQUxHS21HWEY0bWlF?=
 =?utf-8?B?aHg5aHRBcm82b2piSkZoTEJnazhpeEt4YVJ2aXFxcTNEMklIWEVDRWE4ZEdz?=
 =?utf-8?B?L3RQbEJTYjAvRElpem5OSXdKaENEOWt4VFB6N1h0Qm9xLzQ4N3RPdlFjV2hP?=
 =?utf-8?B?SC9jRE9sSFhpV1VsWm45QXZOTFh6UG9KdGg0citpZTkvOXJVNzNzeTNVRFhu?=
 =?utf-8?B?dm14YlhybTVuWUhRbXQxaVBQbjlucDlZaGpKMnlqeWU4UVc4V1lZVzBLTmtP?=
 =?utf-8?B?emd6aWIrTTIvaEwyeTlLZkZPYVhtVGRQYXFYNkJETUVBMHZOWFhFZG9yVlhn?=
 =?utf-8?B?bGdscTN0aUJRS1lUdUw2RXZUa0xicm4rdGpXL0JIeVU3WkJBZjlnQkNpbW93?=
 =?utf-8?B?b0tRRGRIbENzMm5EdVA3ekNNM0dreTVielU5RWlPYWhoVmRaVTU0U1h6SU5N?=
 =?utf-8?B?OUEzaXc4T2tGTTZpODQ3SXJRTFE1NjFwWHAwSlZCdk9mL1h6UzJHRGZTWjRx?=
 =?utf-8?B?YUo2YzlMNnpKL3Z4R05TNjVoaEZ4NTU5eGtHRmlDOEpRTXRRbHdyQ2owREZB?=
 =?utf-8?B?QWxDMU1RaGhUUDg0eEVldEFYdGFydlVmWUcya213TEZJdWw4RllEVE9uK3lZ?=
 =?utf-8?B?UXpqTnZHMFhEY0ZXZXYxeEZydGtaWThDeHFhUWlqZWk3N0NpUW9odDROQW9L?=
 =?utf-8?B?eVZVQ3hpMitoZzNQNVhNb0NjMnp4c0czeG5YdUlVSGFabkZ5bFJhUXFYYnRD?=
 =?utf-8?B?OVByWURMeXJkOTZhZDBqcnZSVGVxS2NicjRiQUpvV0FwVDZ5NVdwRjI1Zy8r?=
 =?utf-8?B?S2hPVnV2WGVzRVRLMHRyNngwQjZRVXZuQlF3Y0E0amlpQzQ0UDR2MkJGaS83?=
 =?utf-8?B?RW1Ndi9TU0dqYkxKenJaTzNsbXNrc25vOEtBdUxnWEhwN0pBaXBVeFdta3J3?=
 =?utf-8?B?TFM2QTJ5cFdJNEpBK2ZuRHduTVZKSkZPZWFPS28vMENDaVVOMlkrTS9TZ25v?=
 =?utf-8?B?bVA5VU42ajl2aGxvS3RJTncvV1VLWnhwNGQ2LytXUEVxeFFzTzNUK0ZpOXEr?=
 =?utf-8?B?eThsWWl4Y0t0QlV2c2RFT3hZL291ajllVUtBOFlFa0dROW1qNDNGSnVrMkF1?=
 =?utf-8?B?a3RYcitOVmRDYWtFbDFEVUw0ZEJWeTVHQ3VIVi9VekFybCt2TVF3aWltdjBl?=
 =?utf-8?B?M0s0K2hSUVkzY0d1S1lBOVd1RTQxa3VHWmtqRXhaaDNqdjFuWnJ5Qmk1cFA5?=
 =?utf-8?B?eTJ5Wnd1M1kzK2xvUlVzVUxjN05HZGdJOU9MeENTcmh3NHlvWjFIdng0ZHl2?=
 =?utf-8?B?QjlSUHc4L3dIVUJkZWt1VXRQbzNZUXV4VmptQUlIaG1lT2M0Vm4xckFxMmhh?=
 =?utf-8?B?bHVUK2d4UUxvb2QrdDc3dVBnK0lEb0EzQUgzV2NtbGc3cWNZdTF1Qk43TmI1?=
 =?utf-8?B?S3ZRU0U4dVdUY0dZM3p5SFJJaUx2NmhyZVpaTFRLUFVON1NpbUc5QWlXQlZD?=
 =?utf-8?B?UzM1Q1doWjlneXlZZ1pzUGg5cWpweHlWaU5Ud2IzVVBhTnYyMC9FdTlUZzcy?=
 =?utf-8?B?dmVTZFMxdENNUFhUd2EzUXpxY0plRVJqMHhXOHdYckczS3VIdFM0SGpMUmcr?=
 =?utf-8?B?WWRJTEhHRE9Zamd4VGhTaG92NE1WbUpxSUdOZjlNamtqdU9BYUMzMG5YQWlG?=
 =?utf-8?B?ejZZOVRXbmxpMjhqMWc1SU9RZnptT0R3TkZOMWl6LzNtWkR6WW5pbVVOQjFX?=
 =?utf-8?B?RndDbWVPZkt1Y1ZOdnR2b0V6MDdITThZRy85OUhiaDZjUXFHWFlpbEQ3UkM2?=
 =?utf-8?B?SGpzZkhmZW9KMXZYU2h2RnhGalFoSnR3emNESEFlU3lSTEE3QzYxVmxQbGw5?=
 =?utf-8?B?ZWRyaXloTlZtSlJlYVdZSEhmdyt1NlVUSEE0NmlvRVVTSjNyRFdMOVliR3cy?=
 =?utf-8?B?bDZMV0M2T1M2Mk9RV3hub2xUZ2JMazJ3dWdHZDRKOVlyajR4VFZOMmRmbHRM?=
 =?utf-8?B?aU5wSU5LREthMjA0d3NBYXhKREw5Tzc2YjFKS0VudGxXTTc0cHJYVjBWbndC?=
 =?utf-8?B?b0NZeDFCWVZhMXR1K2JKMTUrQ1BqN0Y1c3R1Q2kyV3JYWHZ6ZzFGc0FBUmND?=
 =?utf-8?Q?7kEMOW4dExAziHoww2+R6Tk=3D?=
X-OriginatorOrg: ftdichip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0751c7e7-5248-45e5-6086-08da7a8445c6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB2886.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 03:56:15.3746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2456335-1328-47c5-82f2-1fe6783d7182
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wq84I1ew/sHKJ2gJ1/SXEFN5t1Oshd1VSYDAqE/aV0oMUaRsYkzN6dMqeDk2CyVNOgChkOeAxI/Z3INZuABKMBA6Hu2Rd6JZJb7gCMPx/ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB3460
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for the review Johan.

mallik

On 5/8/2022 7:48 pm, Johan Hovold wrote:
> On Thu, Jul 21, 2022 at 03:02:44PM +0800, Amireddy mallikarjuna reddy wrote:
>> Add the product IDs for the USB-to-Serial devices FT2233HP, FT2233HP,
>> FT4233HP, FT4232HP, FT233HP, FT232HP, and FT4232HAQ.
>> Also include BCD values so that the chiptype can be determined.
>>
>> Signed-off-by: Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>
>> ---
>> v1:
>> - Initial version.
> Thanks for the patch. This looks mostly good even I should revisit some
> clean-up patches I have laying around that gets rid of the unnecessary
> device-type conditionals that you're now extending.
>
> I'll either rebase this patch on top or the other way around, but either
> way I'll get this in in some form in a few weeks (e.g. after the merge
> window closes).
>
> Johan

-- 
This email has been checked for viruses by AVG.
https://www.avg.com

