Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F224A56534A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiGDLZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiGDLZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:25:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B55610577;
        Mon,  4 Jul 2022 04:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAEmo5+pFH2miheCnghv7In7gPtBFE1z54xkvpGdKLg512Wn4ZuZRE2JOoyfn1gDMZ6/0HALtxGq8F885dyY11LufFru/5ghIeLZOJrxlRqyJ2kr/PktlQTh9puO6k0bOrMh4XfkgxjQL8F8tcbXSpydVGXVUk6b6OqE4Tp9H3A3ZW+07LgCw1ZmIfsF1n9vwa0J0EWVFN8qlvsOiMDOUUnCwB1yrIE/eNd91t9oHSeLK7UrEvMqFTQzKTr8ahPTVTa6CA3AxOGzoTrMqtLc0rfrTHACvssW1ya53zb23Zvch9a21VJn1UbTUPblYl9FVhUKtWY65eFwfNDhWlPIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLTcPW7A+36V98ESA94Hssg69dQTMHYsa4G/cPtVNAA=;
 b=LMO8BQAEF8fjZdff4I8YnDxsKU8zbOat5aSIvRGd4DOii/7LH74QRI2ne0j397xuL+ez74GertoFVtmoO7rFGD5SZv61H64+Yt/Ze260MCVfjniGc2crxtN1UEn3gQopTTLcXWgqO5Haar3JJD2MMcZtcYJCjNkRS0ioTIANiBssRLQPOAx8p8PlJu9HLZ2HxeLFzeRxzRQntpwqCybOwye0Ny2SUP+VJD7tmP1P1An2fhs7OkpzeyHfM6Kdgz5x9M2bYspY7PNxhsozqx8OkrPQ4QHrmGNz4Ya61HMe7adHkUqb/zhgZjJMgzmDHnVfhxOHT1PHQoDrrRJ21mFaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLTcPW7A+36V98ESA94Hssg69dQTMHYsa4G/cPtVNAA=;
 b=l3z8jBMmFutGw73kwHNguzae1VCXNxzKqdKO4snsodfwqzjRt+zxUulse2Q9BlFoa4aqiWsyG4q32EsE3J7U/tAsWuyvZqt2aFIlVl5Ot+Vw5ikpUFYI5Lq25uEEBmFfBwJfXZjLbAsqUeh48n6pBubZTB1/DPI0PXm8yBzjqyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Mon, 4 Jul 2022 11:25:39 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26%9]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 11:25:39 +0000
Message-ID: <84e26670-5e0f-61b8-8912-42bd048faf16@amd.com>
Date:   Mon, 4 Jul 2022 16:55:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: linux-next: Signed-off-by missing for commit in the iommu tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220627084115.559a257f@canb.auug.org.au>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20220627084115.559a257f@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bdfae26-17ff-4ccd-de25-08da5dafebfc
X-MS-TrafficTypeDiagnostic: DM4PR12MB5184:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aExP+S5jnLuBASy5nfu7GoNWJiB3tSDMrBHl0D9g5IN6UbMXjqewByn8CL6saN4UNcysV8tvDfUqYMLmEH1JW+unvmidN7pV1aKl/hWe4Rr/V+wZQrSrdb84byAXMLwh9YnQ/vp4PI7a5p3e9Eglxat9yZ81r3Hj8wARPHLgtnufYIi1jQLdi4AUj4bvPfA5Kmwt+Vb89noMCm+XCDa7o8PqIBl4aOIm4Qddem0gWA3XP4bPTITSp1noNtQkbcATBLikEiB7SIvj+vHoOglTFRH92LUCqzgAW+8p8MRWR4LSD5CPGBegopmR36b5eo0rfFEKltzfQeYzzF2V4SIfJmlspdSR0DvhQw6nhutGq/w62tZvNOcLHf3t2VKHSkt3r44L/Zuah2tN8Whea5b/ajia+LW+ARiMLmVx2kqyo8XHoa2I/MDAqZPQvHFXb6XqQvaMX2QOZIVaWf8uTt9ZLTtbR94R4D4/UjpIka6nbxed7a7P4ZqyB0Y4d4phzXHPtXovxKLQml622y3h7n74X8voGsupwKOdr10opaoyU154/4DD5Oq4mbYAEYsfBECJHXayXX1qhxMu9MjJh4tpcLqocolKw2q502zBeaA5absem+OLbB6QYQqQ26nq2pjcy7edMKcATT8NRyKt+bl85RBezTiuUeL82B2IVOUnx80AxWsmNDhFBN/Rq6KCsQ0RTBGOhgShxEuuIDp9D6KfEF48rF8c35z2RTep1ZTdy4of7E8/4SPoRDOju9wP6XGo624FjkiWmoCA0t8t6Wl2zcR9lVjowlnZZbpNnki+mB00aWiaXVEtMSQ1V8R1gwyk2HGWwIAtYtJtDlGYPhA7KJ7SAuAe5hNsAOHCb6OCnhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(36756003)(4326008)(5660300002)(8676002)(31686004)(44832011)(66946007)(66556008)(66476007)(6486002)(478600001)(6666004)(316002)(2906002)(54906003)(110136005)(38100700002)(6506007)(6512007)(86362001)(53546011)(31696002)(26005)(186003)(8936002)(83380400001)(2616005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1VyMHlvYWVqSHIxWXN6RmxMZ05QREUzdkpJTWcxaWpsOWFKVW9LckhRajV3?=
 =?utf-8?B?T0gwcm82WWRDUzcrbmhFV0pUR2VKZk9QaWRQT0pIR2kxL3NKS3hUM3FLNlRF?=
 =?utf-8?B?NVhXTm9PdGFIRHJoR2wxKzk1MnRLcUlpaCtRWUcvR1JLWnhnOWpLaTZEVlNT?=
 =?utf-8?B?TE10ZWNGNy9HbHVlMmtRVTdrM2s3SmJVcks0UmxSVFc1Zlo4S3pEdXg4emRE?=
 =?utf-8?B?TUlrbVlsa1hCMjBrWTQvWGdHR09zREFRai9SdFhNa3NsMm12dHdZZGpiVUdF?=
 =?utf-8?B?L2ZTY1ZxOFRYZFFrWk1mRnVtTmxoN3djSjFQM0EwaitJQnJ2cWptQ1NEWmwv?=
 =?utf-8?B?SmVoV2ZlR1VyZ1c1a3FyYkJrV0dTTnBEU2NCQ2xnR1hpMjdnVlJwVzBHMW82?=
 =?utf-8?B?NnFrSVBPQzVKRTIyRnRxa3NNNXhTMDJRREU0YXg1YUo2d2UwR3RFa0VYWWpN?=
 =?utf-8?B?eEFDZEdmS0k2azFqMVlxeUtFL0xZV1NXNEdvdGpRRy9Jd09rWmFFanlHajVX?=
 =?utf-8?B?WU5sSnFtK3UzSzMwNkhvQ3lubFJ2a1NHK091Unl6OEJaMVJBeW84RWcram1v?=
 =?utf-8?B?NDRjWFJOVWl3Z2d5NDBmSk4ydE9OM2h1MEcxaHZ4SHljVkM1Zjh1Mm5oTGIy?=
 =?utf-8?B?MjdKaWJoTTFWR0Y5bkJaVWx0VGJCODcvbmRxb1VlOEdsMGNoSlpQeWo5aG9E?=
 =?utf-8?B?dGNXaFA5RWRTVmh6Zjdwdi8wTFdqWTdmRnR4enFaOUFvZm1sRjN0R0U1dnFa?=
 =?utf-8?B?Z0pQckZkbFBjTG5uSmZ6dFk0eW1kT2Z2UUYvMFFDSTRCSC9CMFJvdHlWN1Ra?=
 =?utf-8?B?NGJaQUhyL1dsdGcrelEvdDQ4Ri9YbHpyM2NWMjM2d3lPaE56Z2lmVEdZT3FC?=
 =?utf-8?B?M2ZPNXpsNkJLdjZHa1hQQnJmelJFOHlRVDVXR25BUlVXandyZUM4cjhuVnlk?=
 =?utf-8?B?bWhaMDhoQVpwN2YrS1JhYWlnS2RiU0svR3Y2U2hUODFNclhnM0d2ckhvSHZW?=
 =?utf-8?B?NTZ5ZHpQa25wYmZQbmhWem5YNzZrMkZaZHZxQml2bVc2WVBGL00yZFVWcnVC?=
 =?utf-8?B?dnZKaVM5eWQxcXhiNlhuQzV0SHdjaEc4SWVGankxRG9FS3NHZEovKzVUOUNS?=
 =?utf-8?B?eVB5TlMrRmlqblQwOGtDenMxdU5tQ3k4RCsyb2k4aDFMZHlqMitESTVWSWN0?=
 =?utf-8?B?bDdXMHdwVzNiS24yYmU1UHIxa09aSjFBWFl2d0MrQnZ3c0NSR3dRS1ZJTUpT?=
 =?utf-8?B?ZnltcGd2NU1FMXZwYXFLWWVTMVVyU29mb3RDQlZYcTk2THZ2Rkh5ZUk4bjgw?=
 =?utf-8?B?Zm5sdUtwM2dYZUh2aWxXK3dSbjV2RG5JbGJrdlQ4SUNaSjhhNU5udmY5RmZa?=
 =?utf-8?B?cVptTHNuWTlOSWYwdDRpSlY3MTh2T0xQbFFvNE12Unk0YzZjVzJ6TTA3R2RU?=
 =?utf-8?B?SUhIZ3BmbERyOHh2dkxidG9tRURzTDh0NXpVUTNlU1hNazBJVXJWbEt4aVk5?=
 =?utf-8?B?Tkd5Sm1tVURXb0FwUERXdzhkWGVSbDhBUWgyKzNTVTZWQnd2MU4vankzeENN?=
 =?utf-8?B?NlduWUJSOWoycU0zWGdXN21yL3dMb1QzWldnWDRxbGZKdDVBcUpoU1RNd3hJ?=
 =?utf-8?B?NzF3Y21nU0NlZXlFdXFpUXVzTjhQZ0p1T212WTQydXhHdTMrVXhnVXFBVnNP?=
 =?utf-8?B?WkxTazNrQjR3R0xxR1dCazR2Z0lHS24wcXByQ0ZrMlBGV244QTlyb3NkZkdC?=
 =?utf-8?B?cHlURkFVTmNtOUl3VzFWUDVqdGJJWnFYZi9mWGJtZG9zU0gxTnZZMmJvdjZN?=
 =?utf-8?B?Mm9DdEp0R2JIWXZsTlhyV21OQk9NSjl4WVorK1gwVjFBVmJraysrd213MTJa?=
 =?utf-8?B?NWFLV1AwL25LbVpLdW03V0JXU01obTVwUFZxSjMzaDN6Qm5FQVdvUXBRT1lO?=
 =?utf-8?B?N0R2SW5hRUNhcG9jUTlOK0VvLyt4UTE5emY1eTE3elNIczNpdm9IbGdzOE5E?=
 =?utf-8?B?akJ6bThVZWdVVTBNbkt0V1k1aWVHZnFaRkg4RFdSU3NQZTlKK1g0bVlFM3hO?=
 =?utf-8?B?bXIvV1pFVmRPUytwMEJPOWo1RnppMzhxa3lsQnh5LytiTmNrNXdvU0FJRU1Z?=
 =?utf-8?Q?c4GKGxdeBLetChChD1g/GjPzo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdfae26-17ff-4ccd-de25-08da5dafebfc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 11:25:38.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhq0+22GV68xV/ofrxbN9AIwrXda7bOxAsFF/nZzp+UF6MbfTc73KnC72wV2z8+XWOzajjX0zNFNVjyf2zflgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 6/27/2022 4:11 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   145c15624f39 ("iommu/amd: Update amd_iommu_fault structure to include PCI seg ID")
>   58f1c71a0e84 ("iommu/amd: Update device_state structure to include PCI seg ID")
>   964d21a7654c ("iommu/amd: Print PCI segment ID in error log messages")
>   58e5ca96cb16 ("iommu/amd: Flush upto last_bdf only")
>   5a903a691117 ("iommu/amd: Convert to use per PCI segment rlookup_table")
>   a0eedb5738c3 ("iommu/amd: Convert to use per PCI segment irq_lookup_table")
>   f1bd29bde636 ("iommu/amd: Introduce per PCI segment rlookup table size")
>   d59145a5e129 ("iommu/amd: Introduce per PCI segment alias table size")
>   ad967e9639e3 ("iommu/amd: Introduce per PCI segment device table size")
>   89e9f3d6219d ("iommu/amd: Introduce per PCI segment last_bdf")
>   e202b39618b3 ("iommu/amd: Introduce per PCI segment unity map list")
>   a42d9be7f4e9 ("iommu/amd: Introduce per PCI segment dev_data_list")
>   65ad39268837 ("iommu/amd: Introduce per PCI segment irq_lookup_table")
>   ec6f20c037c8 ("iommu/amd: Introduce pci segment structure")
>   98496c13a2b6 ("iommu/amd: Update struct iommu_dev_data definition")
> 
> are missing a Signed-off-by from their authors.

Sorry. I didn't realize mailing list is changing "From:" header. Will you be
fixing it in your tree -OR- do you want me to resend patches with updated
"From:" line in patches?

-Vasant


> 
> What is really happening here is that the iommu@lists.linux-foundation.org
> mailing list is changing the From: header in the email submissions.
> The solution is to either use th Reply-To: header for these mails, get
> an off list copy of the patch, or make sure that all patch submissions
> to that list have a From: line at eth start of the body.
> 
