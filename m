Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCECD523394
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbiEKNA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242967AbiEKNAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:00:21 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D848233A60
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:00:18 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BCW8JZ010706;
        Wed, 11 May 2022 12:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=j4RhL13CmIIgWMyxE+NrcBedbEIDodz2jkZ2jhS5+zE=;
 b=ostnW4SeEsqw5nICq2IzLFYTZnAyZ+FWCO3JiFXcLo/C7VHySkN2IcvINecXP1Gvc9Ek
 KL3StV7lTetooLrQfX32WJ/mJBkCVRS4mcZIQXglx6ODtK10fmtJBfxR0FQRij7OlhT6
 z9lEZmOM0fEJVsZwWWTq+l1ZxHmFNkunnIIZmXoAqN60bwC8DB4YMTfx2ySWB8UitySk
 dRwrmnbQqfex9wRhEDZtWU6QWq4M+hIsncOb0G1BR57MjCNj8T713y4WwscHg608yRra
 q6L+pEz+TAi9yxtx6WpNfFEZk11TWYGQlwgTtz+ZNiihXFScLU0Q/w3cjl74iPeJ0CzV uQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3g0b9ns7k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:59:29 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id F2FF2805E02;
        Wed, 11 May 2022 12:59:28 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 11 May 2022 00:59:28 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 11 May 2022 00:59:28 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 11 May 2022 12:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2VN+24BVa+WfHW2GTFpI72sRnpL5iMU1sIeb+xAUZX5CXFJ1Tb2WU6odtgnsgquBnEhQfNPC1mgnM8OR8w1hfcIYPlYMyS7+bU/6bdgTiszZgh9zqD8ASjpuApjpXBlbDBC4bt+Ig5EJKn4hvXZEOcdgzt5d2IRKrPK01fvencSKeg6VyfUP4KiWLZBC3trpaL/c9DUgAyl6DR2DOI7nJnhQ+r9FzqDpQ5PxvOZkWKV1KzUMLRDz1yiilDGuRh0BwqIinhmHUVhS7sT6553fY47MJ7zRwEuB9qC1b1kqfmjcG2T6pVMDPjrMWqIbz+c24epV0YGtw55RLvNNZvXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4RhL13CmIIgWMyxE+NrcBedbEIDodz2jkZ2jhS5+zE=;
 b=fj/E7JYnopholYuCJT204K/MxkmseKzFZiHbgLYBE5Dqz41kDGuI5rMOtnAL9A8WpXZcBOdirxgNsKkfZP/6+zVRaC29JGqBMGsZuRe1Sf4lOLF85n6ICsSLzYYxEW9xTTdWCoyTmw58G/btlc5WYRKk68uqBcr6RVI8KYM4l347Oe0K7PDDqsaorqO51B4hnW3b1A/qdIpz0fQ0xgRgNxGqV2C09yZwHbApbEcqVfmr/BE4GWo8KWDke3VzRQouOmTBFvsz3vnJGJL51LZkzFL55B7mZxjHty3KW2mfBX7d/csmOF/BTVc4MGT5N60e8iv79uRgZILkHi2FiKIrTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 MW4PR84MB1515.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 12:59:27 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::146c:a230:f74f:ba1f]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::146c:a230:f74f:ba1f%6]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 12:59:27 +0000
From:   "Verdun, Jean-Marie" <verdun@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>
CC:     Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
Thread-Topic: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
Thread-Index: AQHYYX9+jmnIwDGcaUahEaikkUcKE60XuXoAgAAJu4CAAFXpAIAAE4wAgAF0T4CAAAYCgP//wNoA
Date:   Wed, 11 May 2022 12:59:27 +0000
Message-ID: <EA4DD6D7-4A9A-41E1-ABE3-B1F3A60D973E@hpe.com>
References: <20220506192957.24889-1-nick.hawkins@hpe.com>
 <CAK8P3a045Di_zRomezeah0ZoSGPw0Z6YoYkZtoxx1qOXAtKbbw@mail.gmail.com>
 <7C103AEB-3111-4AE6-9645-CF590388A879@hpe.com>
 <CAK8P3a0OS+4XTG9VmfPwbuQoT+_G5-fSatbJ0g8Y7Y+O6-3YLQ@mail.gmail.com>
 <20220510141124.GB28104@willie-the-truck>
 <PH0PR84MB171830414ADC0DD69BD4116788C89@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1AG5RXW74LbskwMh1yJzXUjrzdL=iqaVz_7W2hExVuGw@mail.gmail.com>
In-Reply-To: <CAK8P3a1AG5RXW74LbskwMh1yJzXUjrzdL=iqaVz_7W2hExVuGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0305642-e778-47b2-2119-08da334e149c
x-ms-traffictypediagnostic: MW4PR84MB1515:EE_
x-microsoft-antispam-prvs: <MW4PR84MB15152F4F349F8174B26876C7D6C89@MW4PR84MB1515.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CLdKK/FCm3X2LCmWLBfPDRJKXI3aTGXkLhKuqMy/q/HNDL8oZblIvHgzIjAi6nkwu6wT/FryF4eMMYR4OOZQaQUyGSaXJ294EYmlNy6hmokzIltNggsKKat/ZtQXwhcVnjZHuzv96r3UyWKN9JKTOddw8JocAfQ/qMtEdGP/UMkBV8QCKzQgBZ3600KyLzue1QZn7V8uJautvdRkaIiyE5yvo9+3Mc05b4BpMEKWWvSVA1JfH12gXAhjIX2irpZNREOax2rKCxXEjg6ydTlOzstN1V52fiyVH2/gCuLwuUjIudyLGFbhFOOBLBU7fgmzW4u3XttY153GLXdK6z/q8uyg+kXkWqPOklBoxO6cexB/t3VF6Xr6P54wyLUFTzkpsnFsdf0oJqDJ/VhfekncyRuR2B6GfaTFHJQ5BMgwbJ7PHCLT5BT0f+zDFq9c/sBc3Ynb7Sc2aibB2X/c9smLK5iFEViffayvZ6Gj0QJb44KbR2zV2MPC1IBT+nT9fvv8+R7yPDc1vhYUy/K0ZH7nfAZDE8L3NwLoXU/fwlsmQer+2DLh4mbHUA75NcYcUuva0+onwystKDOcQq3qO9fkK0M/b81gNLPdAYIlv/SL83khz6bsYkFf4GEVatoxUI5Xn5Yg3O2O8K+hjtdtI0hMHDGs3z0Dicjg1q7ui9mVWbNZHLc+8KsEHTHq5XLh7PEUyEUMv4H7kk1hkKPizsCd98pKMY4X4wpn1Tjd6noKjRk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(66446008)(66476007)(71200400001)(66556008)(6512007)(38070700005)(38100700002)(91956017)(6506007)(76116006)(64756008)(4326008)(8676002)(66946007)(33656002)(6486002)(5660300002)(86362001)(4744005)(508600001)(2906002)(54906003)(122000001)(110136005)(2616005)(36756003)(316002)(6636002)(82960400001)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a001REY5ekpGVW1OandwNTlDOGVpVEdmMjN6UlpNSzhyRW02MGRja2NlV3dI?=
 =?utf-8?B?QTNkbzJrRnBKN25nL2dYZ1YxOWpWb2tmZmxvREtLTTVVRENhK3hWcWY4Sjd4?=
 =?utf-8?B?cncxYlNQcE43c1JjcmVRYVNnZXhaU0QvQ0d5TWN2THBCOGMrSW43Nll1UElz?=
 =?utf-8?B?NVByaXRKb2lRQW5QT25nNFZqTVNlQTd3RkZKNUtHdnR4bkJkd3ZPbVd1SUMr?=
 =?utf-8?B?NkF1NnZ4RjBwZnRYWTFkUXU5dDArWmdhQkt4dmlNSXBGaktxRWZ4bCtZZ1BC?=
 =?utf-8?B?dm1yZ1UrclMrWll5czBER2RlNnB4T2s2ejA1RkdmQWxGTlk5ak04QXdUSHV0?=
 =?utf-8?B?cmt3aHllREo3eUE0VFhCbEttL2hiSzFZRm00b2huZlVUVVB2c3QwMG5pSm5j?=
 =?utf-8?B?Qld3Vlp3c0NsZGllemtsOFFqa3J0eTkwbnhYWmozenNpWjBId1NXcU1ZVDdv?=
 =?utf-8?B?NXVKNzFJYzk4T2JyU2I1MG1wbW9CbjdwbXpOQ1cyL25CbVVwemJvNWlqRGRq?=
 =?utf-8?B?YU1KdmtnY2hwU1hRUmQwUmoyZDhpeC8xT1RyenlmYnpoaE1DVE1DOWxaakhz?=
 =?utf-8?B?Ui9UM096NzFSQWZwQVh4YWlMaVJRSFovaTlmZWFiZVR6L3V0aXFhNzEvSVcx?=
 =?utf-8?B?TThqZmlHNXhCbmtwNk1haGtrN3ZFTmlialFTQzhvS25zcGFTamM2RU9qS1RX?=
 =?utf-8?B?RzBLek94cXNoUmxaL3F0UHRkVGtkMVdaQ2doWUw0cVRUc0QvREJMZ1lReVZi?=
 =?utf-8?B?WnZyZHZ2cFpsQ080Ti8zQmx4aGJNdTI1QzRuQWdyQkpPUWFidHgwWlJFOFo4?=
 =?utf-8?B?WEQ1TnBkQVZEZDRKWnJvOFp6d29RVmw4OURrZi9LOXhEMDJLeDZidDYveTIy?=
 =?utf-8?B?UjBGUXZpUnlJbGtvRU9YcGJGUDZuOTl2Y2VqbGdtSHJiMXIraDdtby9uRjVH?=
 =?utf-8?B?VEF4anZScnVpejZsb0dsaDI3ZWpDOWtnbU91ZDg2a2lqdUgxa1krUDh6MEdi?=
 =?utf-8?B?OW16aHlnb2NVK1hiZ3JhbTM5dEJoa0NmWkU3TGdOUFJsMmRrNmx0ZzBydVQ0?=
 =?utf-8?B?cUtEZzM5WkJPc2ZrYkpnS21BQ2xGYzRYdE1tRmtLZVRZTVBpOTZvTjgrT0Zr?=
 =?utf-8?B?SGh0bE9GVGZTV1BJaGZPZU9MY29kWTdxUVVLS0ljVXNBTkJVdnVROVBTa2xY?=
 =?utf-8?B?YnRiR25MUEt0cTNIRmtBUVh3czRSL1BmVnAzdjJOemloMXRLd0xuL1UzQUh1?=
 =?utf-8?B?NGtJVzBZUENjL3lsa3VKdHdjd0FRdnI5R2ZOQk9hcUw0WE15V1JpY1lrdExm?=
 =?utf-8?B?cXFyVnF4NndzUnRFMVVnR2JmMFhYMVQ4Q2FGakdObFBSYUZrK0huWEdwQmVr?=
 =?utf-8?B?U1VGMS9OMVdKOW9MSVUrcDlsdDJJb0FnMElOdVlJc08zTyt4WGhNcE5GQUdH?=
 =?utf-8?B?NFc1bVlQV1J1VDI5aXNmVHZTL0JXM0tEbGswMldPWnFUY1FiR0ZkcDMyQW1u?=
 =?utf-8?B?bE1jTHZUTGdHampNQUkwN0ZQeE1vQlVCTnN5OTRoOGg3TWFKQkxhOGdaek1N?=
 =?utf-8?B?OEpFeG8rWTlnRzA3eDVFVHZ6R0NtYkQrMWlVUFUvSTg5VWMrTWdlTkZldjRS?=
 =?utf-8?B?Y1lSdTdQbnBocUNrV0JDa0ZFVDdZSnVzdWJRZllCWkdoZ3RZUU9sSUpSczRH?=
 =?utf-8?B?VnZzU2Q3L0o1eUpUNEg0YWFBVitPNjZUVWROKzNkc2w2VFI3empRUXdqU3BO?=
 =?utf-8?B?NFBPbFNQNlloWXk4WVdRRjBXMk9aU0FaRlpkdnFveUFmYzNKWDBhVytvL2FB?=
 =?utf-8?B?YXdMak4zNUNEK3N1YTZCd1l2VjVoMmlvT1NNamwwZVJYOVQwUlBWdW55NGpj?=
 =?utf-8?B?NzFNQlZzZkUvbWpYaGNxUTR0c1NmeHptOCsvdlIzeVVyZnZtU3NpN08xcnNW?=
 =?utf-8?B?dHhSRE5WYy84Qkd1emhWMWROVmhpZ3A5ajJOcUF5RU1kOGYxemVVQ3REM2s5?=
 =?utf-8?B?aGhkemEvVlFUL3pPK21hNXhRcllYcTBrNG9CUTNMbHJBVTFTWmlLWEZpM2kx?=
 =?utf-8?B?b21HZlI0MEJPODJzSVVibWtTdjBsMldkY1FyWkdlNjloQ3ovMEhMUm9oRUtF?=
 =?utf-8?B?enVKMk5WSFRiTVVLbEhGRjNyS3NaSk43N2w4dktqQ2dhSFZTemRFbm8zRFZH?=
 =?utf-8?B?QkJkWU9DTHNMWGxjb25tSnovWklPV2lubHArR3Q4K2tadGp6Skg4RmpKQUtl?=
 =?utf-8?B?a0VtaTlKNnNSMGpRa3Z0YkZvaU9GM1I4eUFxWWQxVDc1b0wwSnBXTHNUTnhh?=
 =?utf-8?B?K043OFBzYk0xQTFaRzhvUnhrQkl4b3lkRlJNVDN0YWdDRFdMb1Jnc0UwWHFQ?=
 =?utf-8?Q?YK16FioQCOx54xH7HBfKFOPiJXFl3CyJaZ+UOWDGRYnGD?=
x-ms-exchange-antispam-messagedata-1: tK9NlOWlYDDukg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <83CAFAF7D24A4C47BC50EBF4BD9E52A8@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a0305642-e778-47b2-2119-08da334e149c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 12:59:27.2276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VB2+s/dBKNpeqmwQ5yrvJsHAXFpZU9auKPYoQmr/nkBDrBtiE3b/vmLbrZ71X29P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1515
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: XFNY3vgMhwmhWy0Oys2AK1wO1_v-GJqp
X-Proofpoint-GUID: XFNY3vgMhwmhWy0Oys2AK1wO1_v-GJqp
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_03,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=551 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110061
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwNCg0KPiAgICBJZiBpdCBkb2Vzbid0IHdvcmssIHRoZW4gdGhlcmUgaXMgbm8gcG9p
bnQgdHJ5aW5nLiBZb3UgY291bGQgdHJ5DQo+ICAgIGNoYW5naW5nIHRoZSBleGNlcHRpb24NCj4g
ICAgaGFuZGxpbmcgc28gaXQgc2VhcmNoZXMgdGhlIGV4X3RhYmxlIGZvciBVbmRlZmluZWQgSW5z
dHJ1Y3Rpb24NCj4gICAgZXhjZXB0aW9ucyBhcyB3ZWxsLA0KPiAgICBidXQgdGhhdCdzIHByb2Jh
Ymx5IG1vcmUgY29tcGxpY2F0ZWQuDQoNCkkgbG9va2VkIHllc3RlcmRheSBldmVuaW5nIGFuZCBz
aGFyZSBXaWxsJ3MgcG9pbnQgb2YgdmlldywgSSBkb24ndCANCnJlYWxseSBzZWUgaG93IGl0IGNv
dWxkIHdvcmsgYW5kIGJlbGlldmUgdW5mb3J0dW5hdGVseSB0aGF0IA0Kd2UgaGF2ZSB0byBzdGF5
IHdpdGggdGhlIHVuZGVmX2hvb2sgYXBwcm9hY2guIExldCdzIHVzIGtub3cgaWYgDQp5b3UgYmVs
aWV2ZSBzb21lIGltcHJvdmVtZW50cyBhcmUgcmVxdWlyZWQgdG8gdGhlIGN1cnJlbnQgcGF0Y2gu
DQoNCkxldCdzIHNlZSB0aGUgcG9zaXRpdmUgYXNwZWN0IHdlIGxlYXJudCBzb21ldGhpbmcsIGFu
ZCBpZiB3ZSBoYXZlDQp0byBmYWNlIGFkZGl0aW9uYWwgaXNzdWUsIHdlIGhhdmUgdGhhdCBvcHRp
b24gb3Blbi4NCg0KU2lkZSBxdWVzdGlvbjogRG9lcyBhbnkgb2YgeW91IHdpbGwgYXR0ZW5kIE9w
ZW4gU291cmNlIFN1bW1pdCBOb3J0aCBBbWVyaWNhID8NCkkgd2lsbCBiZSB0aGVyZSB3aXRoIE5p
Y2sgYW5kIEhQRSB0ZWFtIHRvIGludHJvZHVjZSBvdXIgR1hQIEFzaWMgZHVyaW5nIGEgY291cGxl
DQpvZiB0YWxrcy4gV291bGQgYmUgZ3JlYXQgaWYgd2UgY291bGQgc3BlbmQgc29tZSB0aW1lIHRv
Z2V0aGVyLg0KDQp2ZWptYXJpZQ0KDQo+ICAgICAgICAgICBBcm5kDQoNCg==
