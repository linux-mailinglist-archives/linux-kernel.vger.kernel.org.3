Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB5C59B1FD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 07:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiHUFHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 01:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUFHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 01:07:10 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD421E10;
        Sat, 20 Aug 2022 22:07:08 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27L52gVg007172;
        Sun, 21 Aug 2022 05:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=5HVglNWwRKPi+Jb8M7fncR7uEEsl/QHeH8sDOR4+Gtc=;
 b=HGCusDmQO07+OH6OH+0sCu2agrxPUtjPZAn0srzxRGXTiaO0MwmE5dkLWsPoaQ3RuMdw
 XJPAKAkNGvnCwIoe1ko6JFeugnxmp7JLyqqfBQamwVJacH8DcaX1qm3Mmuyhx/FGjHpI
 c5kYcVwS934sJaedNb+Zef82bLWM2WKlgO/nrnshzuNADGj3iNL/KaHzMz/UXoH0c6nt
 qqa887eQFUk0QivW5MvXjyI5wOHT+C6IBh1wVzjzhuo2N0xCSOX9D9H5kdmVK32miXpH
 lYeWkur9YvKrrDLhKU2zidB2z95TtgvyhdjA7TmeMM2nCVfJLgbBaGLo3qoGHQCgcBqL xA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wqpmger-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Aug 2022 05:07:03 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 23372804CA7;
        Sun, 21 Aug 2022 05:07:03 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 20 Aug 2022 17:07:02 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Sat, 20 Aug 2022 17:07:02 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 20 Aug 2022 17:07:02 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWZb7h2fXqyMai6zCNif+xd0bn7EDbFBlI9sxhImFJBon/KzrycqZ9IcD/hxY1tZ7oZlpJqeJDmbd869ZbDZMApU7f7X0SfLTELKFRmmHcRR3X/B6Yx+T/WrsmM5dq8raEJ83bGWPBsxnDLTYeXr5XCJBT5NCcIX2HG3BsuJt8z/zlWSY+jPlvTFw+35PYTDFz1b7A21ZG7Vl2vJ05D4ZgOJmP+aeamo/8mtM0rN/Md7vpO3jf7aufx8Q56sTzpyeMwat+zqIMJQeieYRiWSzo8yQk5VIatXZOCKZN28FbFyMBFlaCEu3vMuqg75ATnlEakLW9GPfH5VMBu9dnjhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HVglNWwRKPi+Jb8M7fncR7uEEsl/QHeH8sDOR4+Gtc=;
 b=gwbp1e9CmWshXjiJk06G/BzEwfzUTRAd3z2DxNy4lB0c3p9RByK0/02AI87LimhDkaCYVAGLz8TBxvfjW4K9db2n1aNnjKS/j+X7lGLG8xaq4Xzr9Ld9Z3DFHyTur07TdFwmYMmlWbjxQf9FEUobxWf5sJoGDNZ7W8aYAPL9Mt47ZKKQyteKJYf5vUl+6la85uuezQFiduXcoaDn7eTVZRpfUYKZ/ubXCCVGpoCqKfzRzpPD91QSWPHB7NN7Q7KFKuAZ88iXJkt4fn5yfGrIxqpVjkpxTQmzvW51/I2CQlTz8fySzb4n56sljld60BZVMm5Gw8pL+AtnvaEzpqgWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH7PR84MB1487.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:152::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Sun, 21 Aug
 2022 05:07:00 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%5]) with mapi id 15.20.5525.011; Sun, 21 Aug 2022
 05:07:00 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "<Vishal Badole>" <badolevishal1116@gmail.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "inux-clk@vger.kernel.org" <inux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinmoyghosh2001@gmail.com" <chinmoyghosh2001@gmail.com>,
        "mintupatel89@gmail.com" <mintupatel89@gmail.com>,
        "vimal.kumar32@gmail.com" <vimal.kumar32@gmail.com>
Subject: =?utf-8?B?UkU6IFtQQVRDSF0gQ29tbW9uIGNsb2NrOiDigIvigItUbyBsaXN0IGFjdGl2?=
 =?utf-8?Q?e_consumers_of_clocks?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBDb21tb24gY2xvY2s6IOKAi+KAi1RvIGxpc3QgYWN0aXZlIGNv?=
 =?utf-8?Q?nsumers_of_clocks?=
Thread-Index: AQHYhlnsnUQ3P7E53E2XSWzjiEGgZ61iCBkZgDptc7CACQ5ZAIATpDag
Date:   Sun, 21 Aug 2022 05:07:00 +0000
Message-ID: <MW5PR84MB18429934C99C9AE6289D620BAB6E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <CAEXpiVQihEadxsNodarz2-wxSAipfpzEaA8zKpnozszC+weYTQ@mail.gmail.com>
 <20220610194013.DD39DC34114@smtp.kernel.org> <20220622170219.GA6978@Mahakal>
 <20220624010550.582BBC341C7@smtp.kernel.org> <20220626182517.GA26001@Mahakal>
 <MW5PR84MB1842824E0F57D0EC46381B09AB9D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <20220808170001.GB5239@Mahakal>
In-Reply-To: <20220808170001.GB5239@Mahakal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7276702-156f-4752-e25d-08da8332faed
x-ms-traffictypediagnostic: PH7PR84MB1487:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JISSKWE/Ry4l9eiqMB2N3FSn/VJvOwGxduWmlFF56PT0aK+r9K2toly8Lt8QJevCyjc6lENv4dcqZU+TX5/Vt9QFWybyxstnizpPIs+73NnqrlQZlQ7iDiDUGmA0Ydd7wFI/sYg0K1A2BTW5iRyfjecWZEIuIyJf79+ZpCmbdlg5kkMVfAfdQtIEXqsyjyRkWZaLv+v5NmnxQESfHGoCYl3KyJYab2/guhoZIU3lJ1n+ZcGNJVrTKLsfpfxiiPqEHvxrexJMFVnlG5WuZXxBkA0b5XuJKaLv/zpm7sX86VCSXbf5f3yLHnRuALtoPtsficrfcItPSNVQjPa0xWfUJ0KzS+Fcs22hPFVf3F3r9pMKCwAuOlDS/R6K1UDc8nlNfkMQ4YugoM3DnxPdq55X33PHeLWHAecfUhy76aZF6khCLo+kvBI+knCU85bOrgKT0/ajxqxRR6NbtMSVGWUE6XMjejSg2iYUSaHSNK9fWYSdUzgPWmUkTyRa3QUVW+AfGhLGwQ3VNgbgF4MeacWl9dHVy19Biy8mTphsbyo7zxTwoUP9TjAlukJApdS4fWr3hPTvHBZjKj6qEgCxpuFd996OhTtClDHEZ+lM1ofO1HWRIyb1N94HD8vZkhIp/2SXxfCE9/iG6yWAlmmTfKCwKhWyK8iwBbnF917S2GaaycMO+J4uKwkVU4D1z0JgMv6oDi3mTEv93ysOPaMsg293nf0e3VAm1TVUsq8T3Omrxmo1/qhBb9PRi2DDp/KtdEW07fCprT9a/vby4vR77okQP44QrzZ5sTS44TQoXtZFqs4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(396003)(376002)(39860400002)(366004)(54906003)(55016003)(71200400001)(53546011)(478600001)(86362001)(41300700001)(9686003)(5660300002)(33656002)(122000001)(966005)(26005)(316002)(7696005)(6506007)(186003)(38100700002)(2906002)(38070700005)(66476007)(76116006)(66946007)(66556008)(64756008)(4326008)(66446008)(83380400001)(8936002)(82960400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUhjM2YwOGpRZHJKTmJNUDVXMnVQYlFneC9GMTBSSVJXTWFGZWV2bDlaSWV4?=
 =?utf-8?B?N29rdFE2UUh5V2pKOWIrdENkWUFMU1BFTUtOVGdVUVh4RjZUSTgweVlyOHQ0?=
 =?utf-8?B?VWF6TER4QjJLV0FETTJKdkc1M1B1ZHhMMGFtLzVBZE0wa0N6QlRJY3RGbUYy?=
 =?utf-8?B?VEMrWHloaHhJSTZiZVRtUStvQVR1TnljeldHcUZKOVMzL0syNzBkdnlDSWRl?=
 =?utf-8?B?SGFnS1I4aS9hR2hTUkp3SFYwNTkzZUx2Wm9kd2paR3p2bjM2UDhWRkl4VUVj?=
 =?utf-8?B?eUtkMHpkMVFkcFBlTmtuU2pUTUQxa1IwUThzY2dsRkUyeFhmV1dKc3JQS2tz?=
 =?utf-8?B?TDR0ZjVVOC9MK2dzcVZIOXZNdE5FU3NaTDlzVGhtb3RKcUsydmlrOXdvTmxu?=
 =?utf-8?B?dUkvR1pjZndRSUhHVnNWc0NidnBzTTdlS1pNUFpkRFNqeVU1bnNpM3NUV3FR?=
 =?utf-8?B?RkE5Z2tvZjRWVCt4d2VyUHhYQllrRTFBRGpuN2MwWDhMYW93Yzc3dWZEYmQ5?=
 =?utf-8?B?dkU1bHFOUXBEWEgvT2FSOUcwTy9uc0RPeHdMZUFyTm8rbmxNUGhLeHVHejRR?=
 =?utf-8?B?S0lnSW1hRG9lN0JWc2xTalE1VmtxbDQ1eTBoMmRhdUROZGtDY2lGSDRKOERS?=
 =?utf-8?B?c1Bkb0lOOEVFVTd0WHJOcmNZZmI2K1RscHEvRXNOSnZkNFExanlpRTlpRFNw?=
 =?utf-8?B?VDdzUlorN3l5ZFpNOXk1T2xwNndsbWRDSDV6eTZXNWFqc0EvdVpnZHh1Ukov?=
 =?utf-8?B?VVZDTXI4SXVwSGtud0c4aExCUTRlT0k4M2o0MzlUT2x1OEZOUGNhUUxqK0Qr?=
 =?utf-8?B?TnRZVkZGOE94WE4vRlFMYlZQTTdyQVpQY1B1WjZqVXkwWFlHRXZTMi9oR2Rh?=
 =?utf-8?B?MWlGYVBXQkVQN29EWnBiczg3UEtUN1dyRGdUcXFzNzVBcGU5ckh0VnRQWkdZ?=
 =?utf-8?B?cUZLc2J2dFpBWlZLSW5mWWRCTkpsanBKNVJJTFlOTmVSNldpeG9ORzM3RXEz?=
 =?utf-8?B?bGdqbHpzelZXald4Tk1QZG5zTGpUTk5UVUM0UGFFRVRkSkRoRWR1TUJ4dGRR?=
 =?utf-8?B?UFNWcW4zd0oybWhsd3RkeTdpamk1SUc1ZVA4UGNRdjFZbE91Tk12bmtJbkY3?=
 =?utf-8?B?aExyVVZMZ3R4RlQ4eEYvVTQvZE1IUW93elNPTjZNVlQ4UG9wamJmYTBTdDRj?=
 =?utf-8?B?amc2MGthUnZ1V0FoQnJnMlE3TFVVRzArdmRWbHhZZlZ6Nk1iaCtGQ2Y2angx?=
 =?utf-8?B?S01JbVUra3VDUWVwRVVJSmhSY3VzZWhJczhEMHJxamduZlRLekROS3MwTkZl?=
 =?utf-8?B?YjB3bGsyRGJ1REwxUHlocVJVRXRCL21jd2w3MUdpNEJaamoxQWE1STZ2VEVw?=
 =?utf-8?B?V1NpTm9ianlrVm42ZWRId1RLUEpIMVE1NzE4N3ViYS8yMFVyb0xFMldYVFNB?=
 =?utf-8?B?K3l6NHdwVmpObklwZk5qWE5kVUFDNXc3OFFxS2ZGaU5TRkg0YnhCcE5LTmFk?=
 =?utf-8?B?b09lcDFZNVVNOU1MWm5hK04xZEwwN2dKdk1iclNCbVFqTXdVb2NpVkNqOUVv?=
 =?utf-8?B?RHBzWkR6WU11dzk0Sk9PcFZObDRwZ3dKVnh2K3pQblhTNDdKaUdlTlFLMHVO?=
 =?utf-8?B?bFhHZFdSd3RLUm5iVVRkRUUwZ1NKUjhvZTJDU2dKc0hDdVNONFRyaFJBM0x2?=
 =?utf-8?B?YzQ2QUp3NjBXNUtQU2EzT0lreU1aSEVzd0tqdUJJN01XYTdVMXg2VFJ1Nm5I?=
 =?utf-8?B?TTR5WXFSeTczRFpITXRQdW5sSEJLTFVLQXVoSU90UkVwWHlhTzJLdi9TWDJD?=
 =?utf-8?B?c1dzb3ljV0hFRzN5b0tSY29QVDNob1JoVGNJR3BnVzBDTXJaeDk4dFQwamRS?=
 =?utf-8?B?aERLRzQxNldvdnhZRStxNElXMnRQUjc3TkY0b3dPUDRxUzN0U3o3Q1h0Tm5u?=
 =?utf-8?B?bWNzMzRyTGtWWnZtRjEvbEN1RjR5U2Z6ZFlicVU1eXRnRGJIVHdXVzkxS3J6?=
 =?utf-8?B?ZUt2UVZhT1kxZHB6cW83ckFZWW9oRW9mL25vdytoRUFrb08vQnk3SHlPRXkx?=
 =?utf-8?B?Rk9PWTNNczBwN2VRU0pteFN0Tk1EN05Hblc5SkRIRWd6dlZiRVdZUlU1US91?=
 =?utf-8?Q?4+6I=3D?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d7276702-156f-4752-e25d-08da8332faed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2022 05:07:00.7219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGq3E9UJGqpWqtpptaidAnfwNPNo1wXn118aDj8RVluIqeB3orrW3Is5vYESOIbq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1487
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 283EhseHRLDGM1KCk7iehMMI0qpcYURY
X-Proofpoint-ORIG-GUID: 283EhseHRLDGM1KCk7iehMMI0qpcYURY
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-21_02,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208210019
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogPFZpc2hhbCBCYWRvbGU+
IDxiYWRvbGV2aXNoYWwxMTE2QGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgOCwg
MjAyMiAxMjowMCBQTQ0KPiBUbzogRWxsaW90dCwgUm9iZXJ0IChTZXJ2ZXJzKSA8ZWxsaW90dEBo
cGUuY29tPg0KPiBDYzogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPjsgbXR1cnF1ZXR0
ZUBiYXlsaWJyZS5jb207IGludXgtDQo+IGNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGNoaW5tb3lnaG9zaDIwMDFAZ21haWwuY29tOw0KPiBtaW50dXBh
dGVsODlAZ21haWwuY29tOyB2aW1hbC5rdW1hcjMyQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBDb21tb24gY2xvY2s6IOKAi+KAi1RvIGxpc3QgYWN0aXZlIGNvbnN1bWVycyBvZiBj
bG9ja3MNCj4gDQo+IE9uIFR1ZSwgQXVnIDAyLCAyMDIyIGF0IDEwOjQ5OjE3UE0gKzAwMDAsIEVs
bGlvdHQsIFJvYmVydCAoU2VydmVycykgd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IDxWaXNoYWwgQmFkb2xlPiA8YmFkb2xldmlz
aGFsMTExNkBnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBTdW5kYXksIEp1bmUgMjYsIDIwMjIgMToy
NSBQTQ0KPiA+ID4gVG86IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz47IG10dXJxdWV0
dGVAYmF5bGlicmUuY29tOyBpbnV4LQ0KPiA+ID4gY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gQ2M6IGNoaW5tb3lnaG9zaDIwMDFAZ21haWwu
Y29tOyBtaW50dXBhdGVsODlAZ21haWwuY29tOw0KPiA+ID4gdmltYWwua3VtYXIzMkBnbWFpbC5j
b20NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIENvbW1vbiBjbG9jazog4oCL4oCLVG8gbGlz
dCBhY3RpdmUgY29uc3VtZXJzIG9mIGNsb2Nrcw0KPiA+ID4NCj4gPiAuLi4NCj4gPiA+IFdlIHdp
bGwgcmVtb3ZlIGFib3ZlIHByaW50cyBpbiB0aGUgcmV2aXNlZCBwYXRjaC4gV2UgYXJlIGZhY2lu
Zw0KPiA+ID4gaW5kZW50YXRpb24gaXNzdWUgd2hsZSBwcmludGluZyBjb25zdW1lciBpbiBzdW1t
YXJ5DQo+ID4gPiBhcyBnaXZlbiBiZWxvdw0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZW5hYmxlICBwcmVwYXJlICBwcm90ZWN0DQo+IGR1dHkgIGhhcmR3YXJlICAgICAg
ICAgICAgcGVyLXVzZXINCj4gPiA+ICAgY2xvY2sgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
dW50ICAgIGNvdW50ICAgIGNvdW50DQo+IHJhdGVjY3VyYWN5IHBoYXNlICBjeWNsZSAgICBlbmFi
bGUgIGNvbnN1bWVyICAgY291bnQNCj4gPiA+ICAgY2xrX21jYXNwMF9maXhlZCAgICAgICAgICAg
ICAgICAgICAwICAgICAgICAwICAgICAgICAwDQo+IDI0NTc2MDAwICAgICAwICA1MDAwMCAgICAg
ICAgIFkNCj4gPiA+ICAgZGV2aWNlbGVzcyAgICAgICAgMA0KPiA+DQo+ID4gQ29uc2lkZXIgbWFr
aW5nIHRoZSBrZXJuZWwgb3V0cHV0IHNpbXBsZSwgZ3JlcHBhYmxlLCBhbmQgcGFyc2VhYmxlIChl
LmcuLA0KPiA+IGNvbW1hLXNlcGFyYXRlZCBmaWVsZHMsIG9uZSBlbnRyeSBwZXIgbGluZSwgbm8g
bXVsdGktbGluZSBjb2x1bW4gaGVhZGVycykNCj4gPiBhbmQgbGV0IGEgdXNlcnNwYWNlIHRvb2wg
ZG8gdGhlIGZhbmN5IGZvcm1hdHRpbmcuDQo+ID4NCj4gSGkgUm9iZXJ0LA0KPiBXZSBoYXZlIHJh
aXNlZCBhbm90aGVyIHBhdGNoIGZvciB0aGUgc2FtZS4gUGxlYXNlIGZpbmQgdGhlIGJlbG93IGxp
bmsNCj4gZm9yIHJlZmVyZW5jZToNCj4gDQo+IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3Rz
L2tlcm5lbC9tc2c0NDU5NzA1Lmh0bWwNCg0KVGhhdCBvdXRwdXQgaXMgc3RpbGwgbm90IHBhcnNh
YmxlLg0KDQpJIHN1Z2dlc3QgbWFraW5nIHRoZSBrZXJuZWwgb3V0cHV0IG1vcmUgbGlrZToNCiAg
Y2xvY2ssZW5hYmxlIGNvdW50LHByZXBhcmUgY291bnQscHJvdGVjdCBjb3VudCxyYXRlLGFjY3Vy
YWN5LHBoYXNlLGR1dHkgY3ljbGUsaGFyZHdhcmUgZW5hYmxlLGNvbnN1bWVyLHBlci11c2VyIGNv
dW50DQogIGNsa19tY2FzcDBfZml4ZWQsMCwwLDAsMjQ1NzYwMDAsMCwwLDUwMDAwLFksZGV2aWNl
bGVzcywwDQogIGNsa19tY2FzcDAsMCwwLDAsMjQ1NzYwMDAsMCwwLDUwMDAwLE4sc2ltcGxlLWF1
ZGlvLWNhcmQ7Y3B1LDANCg0KYW5kIG1ha2UgYSB1c2Vyc3BhY2UgcHJvZ3JhbSBsaWtlIGxzbW9k
LCBsc2NwdSwgbHNibGssIGxzcGNpLCANCm9yIGxzdXNiIHRvIHByaW50IHRoZSBkYXRhIHdpdGgg
ZmFuY3kgY29sdW1ucyBvciBhcHBseQ0Kb3RoZXIgZmlsdGVycy4NCg0KVGhhdCBhbGxvd3MgYWRk
aW5nIG9yIHJlbW92aW5nIGNvbHVtbiBoZWFkZXJzLCBhc3N1bWluZyB0aGUNCnVzZXJzcGFjZSBw
cm9ncmFtIGRvZXNuJ3QgaGFyZGNvZGUgYXNzdW1wdGlvbnMgYWJvdXQgdGhlbS4NCg0K
