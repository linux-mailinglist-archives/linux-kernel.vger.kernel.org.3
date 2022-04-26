Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881A551056C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbiDZRcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344407AbiDZRcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:32:05 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC92C83002
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:28:56 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QF78B8031561;
        Tue, 26 Apr 2022 17:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Jy1p+vEQOQeD22L/KIgLVQ/TLTXfL8mZlAWdwTCwLQw=;
 b=nSSPHLWHLobz+x61JQRokDDfOXFfzGr3X0lFRMJ4rjF5jJYoRSSVtuquGLNyNuuYB3Y9
 j2q9GLt9X/PfSKlaMiZmJDCLWBLMxJQ5C/VgHvREicbrmOzE9K7QXM4mVEsDbV+oPHFk
 g9Y+I8lNH9H/eQs4mcVG0pVFcukEkjVkAFh384Ft+ruKLfQscrDbXXNR6xb3F0P/4THm
 jixrBEjLiSSa+d7Wo2VVEqbsFPCkLsy005c9sMBcv0ckcdJUwKm60X+yd014me4clUmZ
 sJmTvdfNjms3sGsr80S2t202R54nicohupI9GUS9Ene8U9hjO6hmPqsIO4v8wSwPiiVW dg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fpj0g2610-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 17:28:17 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 225C813170;
        Tue, 26 Apr 2022 17:28:15 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 26 Apr 2022 05:28:15 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 26 Apr 2022 05:28:15 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 26 Apr 2022 17:28:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBSTYOHb4pJNu3IKYFLV9YbnQkx9fCvU/XahFQJ461xceYwecgSAGbdLKL6gla7CQCJV24NA8r8O3kXOQBfZJGzqG8ghI+DwmH/wW/bw+k/gkph0ZmZqzK/r6VIe/4qfPoziMjWtVzQYWWqUTI7cKQpIBtu85KdGAUHMj7BbH21TufQ62FzMbgMQlWC8l7A8SI414Z7lRP0EXHur4zL2pf4TaWLSzVCecEKAnaTgAlK2gz5lxqQC22rB427AKqiwdK/ZCU5QeHSFDiRSwPQPrPNJdMlNTofC9zwaMHQJwb8KKsR04iZ2D4kdfS0cItwdtK4FSWI1mWHINUWcWDh+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy1p+vEQOQeD22L/KIgLVQ/TLTXfL8mZlAWdwTCwLQw=;
 b=YysMR3OQUS3UCegFRBHxPk6bmZ2SHT8NatJYg8jItgldITg2M206Dx+S2uCwDOwmlcBfQILxkunM5a+1LV0FwIS+O6At4fBAd51IBfFE2D9RnzmZ8KtxtAhUwl+vK4xBRUvMhhoKxO0QQOxe6ZHIPag/hZcWsxeuBGaVyFij/4KZl4OTcfVUjzBgM8nCe/hVsWPV9FguPzX9G6MhVBUcPiA3MO1eTLJvSy0DFKhRq+ORq400IoESQavXEdkpjidnlSLbTjjsmPUyn1B8Yfo1rOXCa7/x+yIRf56I9S8QSfGilp8LchSPlOHKIZ/B/WfAHmfBLeG3sIyy4RepgIVntA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by DM4PR84MB1496.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 26 Apr
 2022 17:28:14 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 17:28:14 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 01/11] aach: arm: mach-hpe: Introduce the HPE GXP
 architecture
Thread-Topic: [PATCH v5 01/11] aach: arm: mach-hpe: Introduce the HPE GXP
 architecture
Thread-Index: AQHYVbTMAvJPhcL2FE+YX4J/HnMQs60B4vwAgAB6eZA=
Date:   Tue, 26 Apr 2022 17:28:14 +0000
Message-ID: <PH0PR84MB171823121FD62E90495BCB7288FB9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <44c145a8-cbfd-c8e4-8391-76abb9562f97@molgen.mpg.de>
In-Reply-To: <44c145a8-cbfd-c8e4-8391-76abb9562f97@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1503a8d0-2930-4b0d-b1c9-08da27aa24ca
x-ms-traffictypediagnostic: DM4PR84MB1496:EE_
x-microsoft-antispam-prvs: <DM4PR84MB14963F7C5F93A640C5680D7888FB9@DM4PR84MB1496.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8G5wSDziAhlA3OOOVuzJyj1Znjt9Bs/coysicXuvTh/kE+A3iTX3U2EwxHRYxHiY63mg0ludFbZcwzviGO68XsUUj6Gzf3WuMV+baIJfkr8cFYoXPyrnHLQOduSUfonUFtdA1GpjiPbBX40cKUiwblto5oebWDb4XDYONIRWXgfHE7NpQ/PipoxQpurT79yxAJFp1AdH6fAWHxkxxZp/ZMvJu+CKa0en9oYPbKtRLhy/fPrYlXTQVtiAZjVb/kpXASAtviKczzJzITN6QR9nyxrsfTmuKcUiyuOq/Jw+MutI3KFNCPQvSa8+JB1dYvNe81EMwdtZ/fr/qVVmKvogea+50MfFs1z2EjugSj2yl/7rIDMZ5CTNd75cdA4LRnZs5PMBA/z9DxBxbN4CmMUK9tBWFaGY3hIVV+dHo1IAOtW0Y/4n/Qf3/3sZZpgSwOEyy8HtXiK62Cnqcwy/UjPGn7RvNd2pnLZMmo55wxKYXnFVs2/BNtm9nUpfLlZZmwGZaxX1eUD5yt0A7F+/jlppETcTZ8+Xe8hfgdHuFobDVrCmp6G2urquF8wrYdZ9F6AHVIYyVDv3oaDCGlrMKWV6J6hwbsjaiyhpwH5H6Jjzn21EhmavhkWLfMV27N3H14tbsf32bU9hrfgBZysF+RGwbTcQD+ocxILmzPp49Gv3o0tIfPdv6rUd6bwF9V+cvOXsN4h4ir7SRDlp/ZjqTPAhww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(71200400001)(38070700005)(55236004)(53546011)(508600001)(8936002)(316002)(55016003)(6916009)(122000001)(82960400001)(7696005)(86362001)(52536014)(5660300002)(6506007)(38100700002)(54906003)(9686003)(26005)(8676002)(4326008)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(186003)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2JxZ0hPamcwZkFnaWNMYnlKTVk5TFdQZEg2cTdFRlNsSFRiVllvWXo2SW5u?=
 =?utf-8?B?aTFOUnlQSjJIOU1VRUJCZHFSdUMvbXBmRkZqRFFuYWxJZHM4UTFYaTNJYzM5?=
 =?utf-8?B?cDZ6clhoRVlrT0JDaEk4TnFpWC81YStYNjhJVDFqSmcxa3JTc0IweHU3QUJy?=
 =?utf-8?B?eFZ3UDBCeTJLTmtqZjNyMHhBZGlMR2hxOTNOcnQ3S3hVOHdPVHhybW5INVpF?=
 =?utf-8?B?bk5qZExnR29nUDNvR3FxV0JYbmcwb0dYNktiNFA1alhpdkZNYzZCbEdJWHdl?=
 =?utf-8?B?WFhVK2hjVkU5cGJCY0g4NVh5RGNFTWFxVGRWRC9DVld5cnpITC92NEdWbFRk?=
 =?utf-8?B?a1ZjZmxrN3F6N0JnQ2JaaEhOc0hiTmJIT294bjcwZTMyd0N1WTNlZEwvT3d1?=
 =?utf-8?B?NzlhbDdYNW9qWmtUbUtOMWRaeXRIc2JCYmFpNE9mRmx3cU1xRGxUQlk3dkFz?=
 =?utf-8?B?dzVxOUM1K3U5Y29zQittazNSbnRDaFd2SkJqOEFXYWZMRVhuYWRpaFZwdVpz?=
 =?utf-8?B?VXRKWE5MWmhYTTdINWxYbVB0TjNIL0wyMHIyZ29CUUs2OHNmS1hzMzRnWmxu?=
 =?utf-8?B?MnlvUVNTRk9JWm1LQ2QrTy9paGtiTnFObk9IM1h1Rmg0S2ZnUm9qdFF3Wnl0?=
 =?utf-8?B?ay9WSW41REEwT3dNUVpuZEZmamZuK3NXaVJYOW1XUkg4VXhKa1pPVjNySGtY?=
 =?utf-8?B?RjBIOTh5R1FEaWJEWm5tY0ZVcjl3em5OazB1bzJIZ3ViR0NaYXRGbWtiemhi?=
 =?utf-8?B?VlhpcnRwbmsvRzR1MFpGc2RPZjhFQU9zdzY1eldMaDFRZ2hXUlgyeUxtdWR2?=
 =?utf-8?B?cU1aTTExMndjaGJPSVN4M1U4b0ZUNnBRVmR0SUxRVHBiZnBaaWJFTEJvVGYv?=
 =?utf-8?B?czdlTlRnM00wSkovZmxPczhra1pTS1pmQTcrR3ZteGZMTXlIY1FhTCtWbE05?=
 =?utf-8?B?dHpOYVhOdWNPeW1rQVZXSDQvU2tMVVByVEpIMzNWUmFrbUtVVzZZNVIrckor?=
 =?utf-8?B?Y29wQ3ByUHVqUHhoUEZNQVVicmcwVUNxM01iVFR2d2prYU01ZTFFMm1XZEpF?=
 =?utf-8?B?cS9QZEttNTdyeEdwTzlNdnFOeDhwRWtUc1UycUo0NitydEEvNUIrclg5cFpX?=
 =?utf-8?B?ejd6Tit3RWYvdVhEZ1BkSGZtd1RxalV6aHZmR1hUaFpaOTFDVnBvK0hxT1N3?=
 =?utf-8?B?K1hoYVVSbFc3NXBuM1FKWDJsaHNxMnJJajJaTzQ3SllYSGhmRWFSVnVzRTlC?=
 =?utf-8?B?REprN05CbGl0d2lneGkrelBsc1dRS0ZNZjBTTFVUOEtDN1VUZVNRaUdBL2wv?=
 =?utf-8?B?N000WkdPdTE4SEJiT0pPRVlrUTB4bGQxNXN4ZDB6SlVuL21tSitwSk5WL0Mv?=
 =?utf-8?B?K3cvekZKdG96dWYyOEp5cjNPb1Q1bUY5Q2JWMWJkRnFGVzVEZVpRSEU5SFJm?=
 =?utf-8?B?Zmp3czZiNHZCcFh1c1duK3lKaWNiTHRXUWhKT2Q2N1dBL01FaldTMldOVE4w?=
 =?utf-8?B?M0oyM2g0MXlFM3dXazZtNHltdVl0WWJ1V3JxRHdsUWpoYk1nOFhnSm5IZDA0?=
 =?utf-8?B?WWY5aEtJSVZUZEtXL3kycWhtS0hpVFhncHhza3NzQXlVMFVXU21CNkJwdVly?=
 =?utf-8?B?VjlLK2pIRlhHNVZvZ01hRWRNK1RaVmhpditLQ1lIOWlUZ2ZRNGQwT210MVZo?=
 =?utf-8?B?U3hjOGJwVlJyaVl5a1czdDNDVmgzZXpkc1Bua1JqV1NsOVJ3L29BVUY4VE51?=
 =?utf-8?B?NmR5cm41YmpuaDRiTktQa2dPOXdWOVNZVUl3diswZmNCTzhyTWlEUFhSRkwz?=
 =?utf-8?B?VzVIbWZteWd3MVcveWhBVTZzVG04bndqNTNvcFlIVFhtS3ZCWXJJY3BCc016?=
 =?utf-8?B?ek1BS1pXWURyNUdFN3FVT1JlcnFqekRaUGIxRXEvaW5kYjlQbU9OcVJFMG81?=
 =?utf-8?B?bklMSUZFOXk1Q3NQdU81bU5vNnNtam0rRlQxZjRJK1V4UENyUDc5NzVnK3JF?=
 =?utf-8?B?aEdrNm9FS0JxVFVON2hIaDhmZjFXajZjSXc5Y1BoT1A1U21IWExwK29pMDhz?=
 =?utf-8?B?aVRsZC9oOUIvMVBvazFLajNlem5Ha2FFZHpCMys3SDdNUG9EM3BiL1kwR1ho?=
 =?utf-8?B?ZTV0NVhLdWNKVlZrd2JOZEFFMXUrVHNtZGFadEpDQW1sN3h3OHN6NmY0UEs0?=
 =?utf-8?B?S2Y2N1czSmM0Ujd5NHYzUFVQMFRNK01aUEVqNHI0c1pDcjZhelBTTnB6bG45?=
 =?utf-8?B?UmFKbWsxbzd4NEEvVU5ReVR1bGNoQjZOSWpDZGVyVEtpTnFUeVQ5ckxhY2Yw?=
 =?utf-8?B?KzQySitLRlpLWHhjSU4rcUVpTTI3d00waU9HRDZkZXc3RVk4L1c1QT09?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1503a8d0-2930-4b0d-b1c9-08da27aa24ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 17:28:14.1221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OoTER25hVOnSQ148xZ2u6kwHzZT+4BBiEDGUYnu6KtV7Lzqyyua2xkqVeXLZ6F6k4ke0TBupjp3aO00zHovJfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1496
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: a530SmXtWeesP2HUZQfTvuRboPig7XMA
X-Proofpoint-GUID: a530SmXtWeesP2HUZQfTvuRboPig7XMA
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204260110
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQYXVsIE1lbnplbCBbbWFpbHRv
OnBtZW56ZWxAbW9sZ2VuLm1wZy5kZV0gDQpTZW50OiBUdWVzZGF5LCBBcHJpbCAyNiwgMjAyMiAz
OjI2IEFNDQpUbzogSGF3a2lucywgTmljayA8bmljay5oYXdraW5zQGhwZS5jb20+DQpDYzogVmVy
ZHVuLCBKZWFuLU1hcmllIDx2ZXJkdW5AaHBlLmNvbT47IGpvZWxAam1zLmlkLmF1OyBhcm5kQGFy
bmRiLmRlOyBvcGVuYm1jQGxpc3RzLm96bGFicy5vcmc7IFJ1c3NlbGwgS2luZyA8bGludXhAYXJt
bGludXgub3JnLnVrPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAxLzExXSBh
YWNoOiBhcm06IG1hY2gtaHBlOiBJbnRyb2R1Y2UgdGhlIEhQRSBHWFAgYXJjaGl0ZWN0dXJlDQoN
Cg0KPiBUeXBlIGluIHRoZSBwcmVmaXg6IHMvYWFjaC9hcmNoLy4gTG9va2luZyBhdCBgZ2l0IGxv
ZyAtLW9uZWxpbmUgYXJjaC9hcm1gLCAqQVJNKiBvciAqYXJtKiBzZWVtcyB0byBiZSBjb21tb25s
eSB1c2VkIHRob3VnaC4NCkkgd2lsbCBjb3JyZWN0IHRoaXMsIEkgd2lsbCBhbHNvIGxvb2sgaW4g
YWxsIG90aGVyIHBhdGNoZXMgdG8gbWFrZSBzdXJlIGFwcHJvcHJpYXRlIHRpdGxlcyBhcmUgYmVp
bmcgdXNlZC4NCg0KPiA+IFRoZSBHWFAgaXMgdGhlIEhQRSBCTUMgU29DIHRoYXQgaXMgdXNlZCBp
biB0aGUgbWFqb3JpdHkgb2YgSFBFIA0KPiA+IEdlbmVyYXRpb24gMTAgc2VydmVycy4gVHJhZGl0
aW9uYWxseSB0aGUgYXNpYyB3aWxsIGxhc3QgbXVsdGlwbGUgDQo+ID4gZ2VuZXJhdGlvbnMgb2Yg
c2VydmVyIGJlZm9yZSBiZWluZyByZXBsYWNlZC4NCg0KPiBQbGVhc2UgbWVudGlvbiB3aGF0IGtp
bmQgb2YgZG9jdW1lbnRhdGlvbiAoZGF0YXNoZWV0cywg4oCmKSBhcmUgYXZhaWxhYmxlLg0KDQpD
dXJyZW50bHkgdGhlcmUgYXJlIG5vbmUgYXZhaWxhYmxlLiBUaGUgb25seSByZWZlcmVuY2UgSSBj
YW4gcHJvdmlkZSB3aWxsIGJlIGFybSBkb2N1bWVudGF0aW9uLg0KDQo+ID4gSW4gZ3hwLmMgd2Ug
cmVzZXQgdGhlIEVIQ0kgY29udHJvbGxlciBlYXJseSB0byBib290IHRoZSBhc2ljLg0KDQo+IFdo
eSBkb2VzIHRoZSBFSENJIGNvbnRyb2xsZXIgbmVlZCB0byBiZSByZXNldD8NClRoaXMgZnVuY3Rp
b25hbGl0eSB3YXMgbW92ZWQgaW50byB0aGUgYm9vdCBsb2FkZXIuIFRoaXMgbWVzc2FnZSBpcyBz
dGFsZSBhbmQgbmVlZHMgdG8gYmUgcmVtb3ZlZC4gSXQgd2FzIG5lY2Vzc2FyeSBmb3IgdGhlIGNo
aXAgdG8gYm9vdC4NCg0KPiA+IEluZm8gYWJvdXQgU29DOg0KPiA+IA0KPiA+IEhQRSBHWFAgaXMg
dGhlIG5hbWUgb2YgdGhlIEhQRSBTb2MuIFRoaXMgU29DIGlzIHVzZWQgdG8gaW1wbGVtZW50IG1h
bnkgDQo+ID4gQk1DIGZlYXR1cmVzIGF0IEhQRS4gSXQgc3VwcG9ydHMgQVJNdjcgYXJjaGl0ZWN0
dXJlIGJhc2VkIG9uIHRoZSANCj4gPiBDb3J0ZXggQTkgY29yZS4gSXQgaXMgY2FwYWJsZSBvZiB1
c2luZyBhbiBBWEkgYnVzIHRvIHdoaWNoIGEgbWVtb3J5IA0KPiA+IGNvbnRyb2xsZXIgaXMgYXR0
YWNoZWQuIEl0IGhhcyBtdWx0aXBsZSBTUEkgaW50ZXJmYWNlcyB0byBjb25uZWN0IGJvb3QgDQo+
ID4gZmxhc2ggYW5kIEJJT1MgZmxhc2guIEl0IHVzZXMgYSAxMC8xMDAvMTAwMCBNQUMgZm9yIG5l
dHdvcmsgDQo+ID4gY29ubmVjdGl2aXR5LiBJdCBoYXMgbXVsdGlwbGUgaTJjIGVuZ2luZXMgdG8g
ZHJpdmUgY29ubmVjdGl2aXR5IHdpdGggYSANCj4gPiBob3N0IGluZnJhc3RydWN0dXJlLiBUaGUg
aW5pdGlhbCBwYXRjaGVzIGVuYWJsZSB0aGUgd2F0Y2hkb2cgYW5kIHRpbWVyIA0KPiA+IGVuYWJs
aW5nIHRoZSBob3N0IHRvIGJlIGFibGUgdG8gYm9vdC4NCg0KPiBNYXliZSBkb2UgdGhhdCBpbiBz
ZXBhcmF0ZSBjb21taXRzPw0KQXJlIHlvdSBhc2tpbmcgZm9yIG1lIHRvIGhhdmUgdGhpcyBwYXJh
Z3JhcGggaW4gdGhlIG90aGVyIGNvbW1pdHM/IE9yIHBlcmhhcHMgbm90IG1lbnRpb24gdGhlIG90
aGVyIHBhdGNoZXMgaW4gdGhpcyBwYXJhZ3JhcGg/IA0KDQo+IFBsZWFzZSByZWZsb3cgdGhlIGNv
bW1pdCBtZXNzYWdlIGZvciA3NSBjaGFyYWN0ZXJzIHBlciBsaW5lLg0KSSB3aWxsIHZlcmlmeSBh
bGwgdGhlIGxpbmVzIGFyZSB1bmRlciA3NSBjaGFyYWN0ZXJzLg0KDQpUaGFua3MgZm9yIHRoZSBm
ZWVkYmFjaywNCg0KLU5pY2sgSGF3a2lucw0K
