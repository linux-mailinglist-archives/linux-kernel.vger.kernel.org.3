Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4134F1C1D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357628AbiDDVZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379070AbiDDQ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:27:59 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B513192F;
        Mon,  4 Apr 2022 09:26:02 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234FekdG014068;
        Mon, 4 Apr 2022 16:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=BPEar6P+ZvbYcLOP1rFH//N9CBszlKO9eZtcX23ppKk=;
 b=fI4l58UVE/J/c5u2UGzgph0qiKhecXp5K5YwwngAep5psNmiNmj7ATJWJ0WhmBUWZPAW
 jSKkvdwW55JUoC2b1rCAx//xr2g/0bA90zQiPzOnuW5IRgsLkqKunyJ2VHUSQR2Ix3Bm
 s5tyu9iXVXj+PtNagpsK1XEV/w4JwC3hghsDjHLhym8gPrqJAD5l6WEY62/N36+hHKpq
 4EfLYs/tt8hxh7fLhIMDomgFnRFPqFaP2YFpXmkBdC3kaJZSzlWfsswy6WdQeBcld+wN
 XCC9f8uOBWc2YZgi8uRI70IBs83033jcGXx2GgVlRJbTECHu2FEF3HvftZcsJn/mXTR0 bQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3f7w0nm6py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 16:25:48 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 4107B80038C;
        Mon,  4 Apr 2022 16:25:46 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 4 Apr 2022 04:25:46 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 4 Apr 2022 04:25:46 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 4 Apr 2022 04:25:45 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSR3ucbrZFuQ7XoFnNfRzo3vKRVa8v8/fZ//UNjmlxP8zB6pVijUhqWWkuvDRRrucwpSml0li3TYeXDzFHSAyUV2RQloKD2Cbc/n3u58I6XsR75EbydjQC/10maC+C5Z2GaHzn0+OIP1XsbW/trLqb0VuIqdnOCVQtQSo6Dfl3CwG2OsPVU2fhbflFE/G53B0MJ4yCaYTO8j5Ng9pnn/RflntLJ1eENcDhevsx+g3VqRSipUXpf8/SqWFdShHxuhQOVzcJZ/V8Ih0qpppNvwTs/AfkGfclYT7LbJq2s0qv9lzv9FHB6xyUthzLOF06im+IVZ2+u0REmUDAjD/j/smw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wV6KqpFFo30gMfwzuG0kNMDL6S99BVHSsDGpvAV884=;
 b=IcjTDBknhxB/IrLKO0fhGjAegxl/P69kQH8lbFDkwug5YOMHnzktqzYLWxMciYUPbKLaaZUEN2gjfweXuUFPSVEQVLkTTLR1QYojjmz8fAN6zCSOSrtpcDtHTP2pPOcefhlcjL0EvNbiexoc92Zh4gHNCvDNSjcQ1gkrh3F5xx9wjHrb/wpJt6lGvXMLbqy6IGhCg5dW3+h23gZlASdQNg8U8XNVq0bRRv/0tupUU1zSxNj7MPmSvjlyR9unnQ9d+Cs85bDQszdoSka/YM8s7BelLezekGBmjN3A+pbKmJzQE6rEHPz6EkCKPRa3kP6RbYQl/5RmusF6d+7aSWpZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by MW5PR84MB1570.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 16:25:44 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4%7]) with mapi id 15.20.5102.022; Mon, 4 Apr 2022
 16:25:44 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v3 03/10] drivers: wdt: Introduce HPE GXP SoC Watchdog
Thread-Topic: [PATCH v3 03/10] drivers: wdt: Introduce HPE GXP SoC Watchdog
Thread-Index: AQHYNLgg81YfOsmkME68rpnLNKjlv6zf9xIAgAAYw8A=
Date:   Mon, 4 Apr 2022 16:25:44 +0000
Message-ID: <PH0PR84MB171847EBCFEF79A06434CE8488E59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-3-nick.hawkins@hpe.com>
 <20220404142830.GA3289074@roeck-us.net>
In-Reply-To: <20220404142830.GA3289074@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a10bcb30-65bc-4f02-2caa-08da1657c4a1
x-ms-traffictypediagnostic: MW5PR84MB1570:EE_
x-microsoft-antispam-prvs: <MW5PR84MB157097F3FCA1865581F8967488E59@MW5PR84MB1570.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pQfZU7nX4ccffMxkYwct8SbNkPpbMn0gB4uq+hqyjJAytm0+z9ih0opIvsDVU0E3xVLoSymlNoUv1LBjBDeKgUO4YuI1SsyvRbzutmJNqIjNWOwiAEcLKFkL92Oba6XitcLGkkcUCGWTImj/qR6qcBObfLVmEAEhHIQiVkMzBczPtCkABAoB3ItEeGSNDJ1s2guXiLiwZFE6C0dL4VpmD3zfbAzL/wDFqu72iLgkEhev3eOUfdlRVDN2v9Uyl1ivpLCZ65N5DndjVs8TkSrPr3KgEO6oLxnmrBlHbVDIHNgTsAWHuvMNn8+PJXLEG2wAzf/JaV47/S5qTi4eaWD5DFRnNr5dYr47W3/1iKyvCaknueJWiFrikjR4D0596ylg+4dpVn742LBhLAS1tnfi1NvlrAnWZeLeCFDuMGjLoWPXj+60ZbPo5aLvsGTMmVgay7XYQIyD50E7o3aNwe8vCaIRLGEBl4DOWh7To83GVokwgOXMCL5tG7N3fQnR11+cHq96VkWe1rtuG/3kCzDvsRuAwh014KkapcO/radNad8+/ZIVzuEqlOiqu1g0dxdRdSelvcUqJS6flP4WXunDUWLZgxQSgxa77usK0qnBOlH4I/Lpg8KzS1XV8fXi1Zlmh92dVC1rSDl1cz2bTFMldxaOIqwBMoRexu9gTjNt9XbxX08CsNEgtr25jXwZhSGq5ay1+LiHPqvcA4tlCTTltp2NXvr0QfH2Ka/MWHl5DoVIAsQIMWuYz13OHSMSIcVlzgUyxjEEin45YxSMMwl7I9qs98tnfOcwbw39E/vJPYFpu2Q6nrTE5XutYBBHm2+VC15sW8NXOah+FOrzKIBNXsoZ+cIx8cHXPOt4kTWkyL8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(53546011)(6916009)(71200400001)(54906003)(5660300002)(6506007)(7696005)(76116006)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(66946007)(83380400001)(316002)(33656002)(508600001)(9686003)(38100700002)(55016003)(8936002)(52536014)(38070700005)(82960400001)(122000001)(186003)(966005)(26005)(86362001)(2004002)(266184004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mQgL4Qk80VfKrckXa+SOlrKY41iPDsmgIhKzWu+tL3Dv1TFkcoTc7xcGKUo6?=
 =?us-ascii?Q?oMl+sluldmHv2f+nJ/qX0+MSrwiMoYQI7dXkkVdNzhMrQIEpSszKA3iqNLsk?=
 =?us-ascii?Q?QatFavxPtoxtBjGdU8yMmzx0GHkdgZPehcOLI+uQwSxni+f6d0eikLfmymKQ?=
 =?us-ascii?Q?U+PLtuFdGHp70vQmg7sP/238gY+imqjUMO+0bFiq+wHhTqPeCO6PEENGOECW?=
 =?us-ascii?Q?qHJkmoQTd5qFbwLhY9krn8K8KqzWfpLFSG0j10++TlTl1LV5wRiPitSnnWPx?=
 =?us-ascii?Q?eRtIIdb9DP+KjGgbi9alPrBShpu5Szk9xhXagiqvstSvYtWKnxPpaQzOD6jY?=
 =?us-ascii?Q?XBkp67VWWpn0ZQ41NJ/HMwzfncaZk2kIbEwKaMQ/nzRYmaeZmswDkY8kic9Z?=
 =?us-ascii?Q?7yvRFiLW0Dao8Ueqz9Dp4ti9vsSmEZG5/4Kgk9SyePMAbRsHqOVFehlh5g8u?=
 =?us-ascii?Q?h9dQ6G3G2bUOvsOgNiLnha7jBTw7YWMcUA2Q+DZoTNK78EnlnOAvwl/wlHIQ?=
 =?us-ascii?Q?FgzyWmGOuCUCXZVNvVxXaTgi1dIpDDOfpvYMbh8DQGE8qnkBJlXbt0nVw5qb?=
 =?us-ascii?Q?Hp5EIlJMFkHetHXUOBqi8UY1mONuVv0+dVEU+lpjmkaWNtUHFILo8oIfMZ9s?=
 =?us-ascii?Q?rL4HZKZyc2SwsvPNfDL7qnU7dJUpwvzaodZs1/nYRYKX8oTQby0wxQa7QC1i?=
 =?us-ascii?Q?h5DsXAHem2J9RPr2OgdZqEZ6iPeCaX2hICsFk8rkJlmxbtIyaM+kxj00jZLa?=
 =?us-ascii?Q?DoAPhbXm5Adspq0vwIdf+MWTzcKY+pzs8qDhRsSPz10iy1Tnm8w5msrS1AT4?=
 =?us-ascii?Q?6G4o7urVo+eOtLX8Y17RdtQYF5foXOYm4VYuZoxApDLhfxOzf9dh4IjusWp7?=
 =?us-ascii?Q?BmHx54fzHML06KhEKGrl+Kui3eJCRuBbdMwJkqrmHs3J8/gzPQEvvJhub00P?=
 =?us-ascii?Q?EUSw+u6CraiJ4o/jpT+ugT/u4UOpO5xmujtBYAjQNHgeZaWYoSrsekOetT9r?=
 =?us-ascii?Q?6ZhEMRwaP/9PVECfH6FXeU811CvgeNZ1rsPX3VavL8bb+SubEpTd89/diENc?=
 =?us-ascii?Q?EjVrHH7zM3NRi30/PEB3uj+GEdJ77N7WDG7FuzXES/gv+X0F+K0mfZUYnz9G?=
 =?us-ascii?Q?P4hr2H599vpULAHDodR7ji8zSyMjgjIpZilTT1o+urh8b0bI+7p3mD7X6Ah+?=
 =?us-ascii?Q?wkuIyo0af/nKBhryV0dtZF66a6jRp3FqTK6VVgu0wW7dGcffMaEAA7gsbfTH?=
 =?us-ascii?Q?RC1POkrdHrlV8d2Ehjp+/qVfZ62MKiiY7B9qzfSUSdvz6tfzekfLhnpmFPHz?=
 =?us-ascii?Q?L7QYFfevVuuE1Ss65nZAXm3CAl3YI3MRfMeGdEYxdmhZraPGv+MSm6IhYOTc?=
 =?us-ascii?Q?vxgHnCbGNC2moTshNIv2TwSj4ufxYtwTPNtOAQ1oNmrKMynjhllexiXtuNvp?=
 =?us-ascii?Q?cegv3SSIho7sZKZkSimZN18ocsz8UTBME2lLXncYNdne4T9ao/JinzlY+phA?=
 =?us-ascii?Q?4w/3gN9FIhR2YPFQF4YwnfqFejCcPH+uB6GilGKjJNOyjO25vqbPXfm8v31p?=
 =?us-ascii?Q?9xB8BYRm3bKLHlQtIphb2fAk7GVrVk5aU2aerjJ+nzg+lHMdhlSNPsbCGMRj?=
 =?us-ascii?Q?sLLjh244xuxBFo+PJmVRBoUyOx7jEQuLKJT6sDzYJ/x7MiEiEgaoFncbg26S?=
 =?us-ascii?Q?LXyZ6YW67tyRtNgTOcw1KMugsfxYzqGfQCyw+V4gmpRr1M3g?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a10bcb30-65bc-4f02-2caa-08da1657c4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 16:25:44.1803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkl6KW8Lr9Yl6y5aVtv95vowTO/G4RQeu/AD9OehI+T6lJ9vWKRbqmgU0hqMEujold3kMGhJXRXn5PQcOlgv2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1570
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: dJtKUKJ9Rf1LEnfD_IkZikPV28LFyZy1
X-Proofpoint-ORIG-GUID: dJtKUKJ9Rf1LEnfD_IkZikPV28LFyZy1
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_06,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040093
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net]=20
Sent: Monday, April 4, 2022 9:29 AM
To: Hawkins, Nick <nick.hawkins@hpe.com>
Cc: Verdun, Jean-Marie <verdun@hpe.com>; Wim Van Sebroeck <wim@linux-watchd=
og.org>; linux-kernel@vger.kernel.org; linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 03/10] drivers: wdt: Introduce HPE GXP SoC Watchdog

On Thu, Mar 10, 2022 at 01:52:22PM -0600, nick.hawkins@hpe.com wrote:
>> From: Nick Hawkins <nick.hawkins@hpe.com>
>>=20
>> Adding support for the HPE GXP Watchdog. It is new to the linux=20
>> community and this along with several other patches is the first=20
>> support for it. The GXP asic contains a full compliment of timers one=20
>> of which is the watchdog timer. The watchdog timer is 16 bit and has=20
>> 10ms resolution.
>>=20
>> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
>> ---
>>  drivers/watchdog/Kconfig   |   8 ++
>>  drivers/watchdog/Makefile  |   1 +
>>  drivers/watchdog/gxp-wdt.c | 191=20
>> +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 200 insertions(+)
>>  create mode 100644 drivers/watchdog/gxp-wdt.c
>>=20
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index=20
>> c8fa79da23b3..cb210d2978d2 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1820,6 +1820,14 @@ config RALINK_WDT
>>  	help
>>  	  Hardware driver for the Ralink SoC Watchdog Timer.
>>=20=20
>> +config GXP_WATCHDOG
>> +	tristate "HPE GXP watchdog support"
>> +	depends on ARCH_HPE_GXP
>> +	select WATCHDOG_CORE
>> +	help
>> +	  Say Y here to include support for the watchdog timer
>> +	  in HPE GXP SoCs.
>> +
>>  config MT7621_WDT
>>  	tristate "Mediatek SoC watchdog"
>>  	select WATCHDOG_CORE
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile=20
>> index f7da867e8782..e2acf3a0d0fc 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -92,6 +92,7 @@ obj-$(CONFIG_RTD119X_WATCHDOG) +=3D rtd119x_wdt.o
>>  obj-$(CONFIG_SPRD_WATCHDOG) +=3D sprd_wdt.o
>>  obj-$(CONFIG_PM8916_WATCHDOG) +=3D pm8916_wdt.o
>>  obj-$(CONFIG_ARM_SMC_WATCHDOG) +=3D arm_smc_wdt.o
>> +obj-$(CONFIG_GXP_WATCHDOG) +=3D gxp-wdt.o
>>  obj-$(CONFIG_VISCONTI_WATCHDOG) +=3D visconti_wdt.o
>>  obj-$(CONFIG_MSC313E_WATCHDOG) +=3D msc313e_wdt.o
>>  obj-$(CONFIG_APPLE_WATCHDOG) +=3D apple_wdt.o diff --git=20
>> a/drivers/watchdog/gxp-wdt.c b/drivers/watchdog/gxp-wdt.c new file=20
>> mode 100644 index 000000000000..d2b489cb4774
>> --- /dev/null
>> +++ b/drivers/watchdog/gxp-wdt.c
>> @@ -0,0 +1,191 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L=
.P.
>> + *
>> + *
>> + * This program is free software; you can redistribute it and/or=20
>> +modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/types.h>
>> +#include <linux/watchdog.h>
>> +
>> +#define MASK_WDGCS_ENABLE	0x01
>> +#define MASK_WDGCS_RELOAD	0x04
>> +#define MASK_WDGCS_NMIEN	0x08
>> +#define MASK_WDGCS_WARN		0x80
>> +
>> +#define WDT_MAX_TIMEOUT_MS	655000
>> +#define WDT_DEFAULT_TIMEOUT	30
>> +#define SECS_TO_WDOG_TICKS(x) ((x) * 100) #define=20
>> +WDOG_TICKS_TO_SECS(x) ((x) / 100)
>> +
>> +struct gxp_wdt {
>> +	void __iomem	*counter;
>> +	void __iomem	*control;
>> +	struct watchdog_device	wdd;

> Odd variable alignment. Might as well just use spaces before the variable=
 names.

Fixed

>> +};
>> +
>> +static void gxp_wdt_enable_reload(struct gxp_wdt *drvdata) {
>> +	uint8_t val;
>> +
>> +	val =3D readb(drvdata->control);
>> +	val |=3D (MASK_WDGCS_ENABLE | MASK_WDGCS_RELOAD);
>> +	writeb(val, drvdata->control);
>> +}
>> +
>> +static int gxp_wdt_start(struct watchdog_device *wdd) {
>> +	struct gxp_wdt *drvdata =3D watchdog_get_drvdata(wdd);
>> +
>> +	writew((SECS_TO_WDOG_TICKS(wdd->timeout)), drvdata->counter);

> Unnecessary iand confusing () around SECS_TO_WDOG_TICKS().

Fixed

>> +	gxp_wdt_enable_reload(drvdata);
>> +	return 0;
>> +}
>> +
>> +static int gxp_wdt_stop(struct watchdog_device *wdd) {
>> +	struct gxp_wdt *drvdata =3D watchdog_get_drvdata(wdd);
>> +	uint8_t val;
>> +
>> +	val =3D readb_relaxed(drvdata->control);
>> +	val &=3D ~MASK_WDGCS_ENABLE;
>> +	writeb(val, drvdata->control);
>> +	return 0;
>> +}
>> +
>> +static int gxp_wdt_set_timeout(struct watchdog_device *wdd,
>> +			       unsigned int timeout)
>> +{
>> +	struct gxp_wdt *drvdata =3D watchdog_get_drvdata(wdd);
>> +	uint32_t actual;

> Please use u32 as suggested by checkpatch. Same everywhere.

Fixed, checkpatch did not flag this, is there an option I should be using w=
ith checkpatch.pl?
>> +
>> +	wdd->timeout =3D timeout;
>> +	actual =3D min(timeout, wdd->max_hw_heartbeat_ms / 1000);
>> +	writew((SECS_TO_WDOG_TICKS(actual)), drvdata->counter);

> Unnecessary ()

Fixed

>> +
>> +	return 0;
>> +}
>> +
>> +static unsigned int gxp_wdt_get_timeleft(struct watchdog_device *wdd)=20
>> +{
>> +	struct gxp_wdt *drvdata =3D watchdog_get_drvdata(wdd);
>> +	uint32_t val =3D readw(drvdata->counter);
>> +
>> +	return WDOG_TICKS_TO_SECS(val);
>> +}
>> +
>> +static int gxp_wdt_ping(struct watchdog_device *wdd) {
>> +	struct gxp_wdt *drvdata =3D watchdog_get_drvdata(wdd);
>> +
>> +	gxp_wdt_enable_reload(drvdata);
>> +	return 0;
>> +}
>> +
>> +static int gxp_restart(struct watchdog_device *wdd, unsigned long actio=
n,
>> +		       void *data)
>> +{
>> +	struct gxp_wdt *drvdata =3D watchdog_get_drvdata(wdd);
>> +
>> +	writew(10, drvdata->counter);
>> +	gxp_wdt_enable_reload(drvdata);
>> +	mdelay(100);
>> +	return 0;
>> +}
>> +
>> +static const struct watchdog_ops gxp_wdt_ops =3D {
>> +	.owner =3D	THIS_MODULE,
>> +	.start =3D	gxp_wdt_start,
>> +	.stop =3D		gxp_wdt_stop,
>> +	.ping =3D gxp_wdt_ping,
>> +	.set_timeout	=3D gxp_wdt_set_timeout,
>> +	.get_timeleft =3D	gxp_wdt_get_timeleft,
>> +	.restart =3D	gxp_restart,

> Please be consistent with alignments.

Fixed.

>> +};
>> +
>> +static const struct watchdog_info gxp_wdt_info =3D {
>> +	.options =3D WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
>> +	.identity =3D "HPE GXP Watchdog timer", };
>> +
>> +static int gxp_wdt_probe(struct platform_device *pdev) {
>> +	struct resource *res;
>> +	struct device *dev =3D &pdev->dev;
>> +	struct gxp_wdt *drvdata;
>> +	int err;
>> +	uint8_t val;

> Please use u8.

Fixed.

>> +
>> +	drvdata =3D devm_kzalloc(dev, sizeof(struct gxp_wdt), GFP_KERNEL);
>> +	if (!drvdata)
>> +		return -ENOMEM;
>> +	platform_set_drvdata(pdev, drvdata);
>> +
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	drvdata->counter =3D devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(drvdata->counter))
>> +		return PTR_ERR(drvdata->counter);
>> +
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	drvdata->control =3D devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(drvdata->control))
>> +		return PTR_ERR(drvdata->control);

> Please use a single resource and offsets, or explain in a comment why tha=
t does not work for this driver.

I actually was flagged for this on our separate device tree review and have=
 trying to determine a better solution for it. The primary issue is that th=
ere are many controls in the register region. The current suggestion I am p=
ursuing is having the timer be the parent and watchdog be the child all in =
the same driver. I need to get feedback from the clocksource owners on this=
. For reference here is the discussion: https://lore.kernel.org/all/CAK8P3a=
1Cc+2oY9djdp11PuOW+TBQ0zf+p8QaDY3aerk1QqaG-g@mail.gmail.com/  Any input on =
this is welcome.

>> +
>> +	drvdata->wdd.info =3D &gxp_wdt_info;
>> +	drvdata->wdd.ops =3D &gxp_wdt_ops;
>> +	drvdata->wdd.max_hw_heartbeat_ms =3D WDT_MAX_TIMEOUT_MS;
>> +	drvdata->wdd.parent =3D &pdev->dev;
>> +
>> +	watchdog_set_drvdata(&drvdata->wdd, drvdata);
>> +	watchdog_init_timeout(&drvdata->wdd, WDT_DEFAULT_TIMEOUT, dev);

> That disables setting the watchdog timeout through devicetree, and is thu=
s mostly pointless. It is better to set the default timeout via variable as=
signment above if you don't want to use devicetree to set the timeout, or p=
ass a timeout value of 0 to get the timeout from devicetree (if configured).

Thank you.

>> +	watchdog_set_nowayout(&drvdata->wdd, WATCHDOG_NOWAYOUT);
>> +
>> +	val =3D readb(drvdata->control);
>> +	if (val & MASK_WDGCS_ENABLE)
>> +		set_bit(WDOG_HW_RUNNING, &drvdata->wdd.status);
>> +
>> +	watchdog_set_restart_priority(&drvdata->wdd, 128);
>> +
>> +	watchdog_stop_on_reboot(&drvdata->wdd);
>> +	err =3D devm_watchdog_register_device(dev, &drvdata->wdd);
>> +	if (err) {
>> +		dev_err(dev, "Failed to register watchdog device");
>> +		return err;
>> +	}
>> +
>> +	dev_info(dev, "HPE GXP watchdog timer");
>> +	return 0;
>> +}
>> +
>> +static int gxp_wdt_remove(struct platform_device *pdev) {
>> +	return 0;
>> +}

> Pointless remove function.

Fixed.

>> +
>> +static const struct of_device_id gxp_wdt_of_match[] =3D {
>> +	{ .compatible =3D "hpe,gxp-wdt", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, gxp_wdt_of_match);
>> +
>> +static struct platform_driver gxp_wdt_driver =3D {
>> +	.probe		=3D gxp_wdt_probe,
>> +	.remove		=3D gxp_wdt_remove,
>> +	.driver =3D {
>> +		.name =3D		"gxp-wdt",
>> +		.of_match_table =3D gxp_wdt_of_match,
>> +	},
>> +};
>> +module_platform_driver(gxp_wdt_driver);
>> +
>> +MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");=20
>> +MODULE_AUTHOR("Jean-Marie Verdun <verdun@hpe.com>");=20
>> +MODULE_DESCRIPTION("Driver for GXP watchdog timer");
