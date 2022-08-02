Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A93A58848C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiHBWtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiHBWth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:49:37 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0552E12767;
        Tue,  2 Aug 2022 15:49:36 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272MibsG015986;
        Tue, 2 Aug 2022 22:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=aBcwqy5rVuadZreo5FWlVUOrcn121dA1tLTMwt/VlW0=;
 b=nn+FYBnnAvwjEEecRWIgeXnudvUWZeCAevyeDk+g30cDwkVlu34201wEn/rdjW1t0hga
 yR3ndrns/2bRbVBmPRgZetpTl9cNUs1ChWTYy+mpU2iYwKX6LXJtL2jt0hfkS7P2230R
 5WonxW7nsL77vJ9olqQXwm/XwGxxTTBpf8iivwmKJAUZPEBq5K2kT1yskJBaR0VINvyG
 njlXLaKQN/2F0iVsr31WQ5UsTpsuTEwHtX/y0+VRkfqn2ihZWHHZWM8jmtdRcZUf7+kz
 l6pQy+3uxz8ma0oDQ6b8WNktj6xuOsLG4G8/XdjEc21TMUVz9h3xnzpY53zjqQ3Lc2KK cQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hqcyyr0s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 22:49:27 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 06BB6804CB5;
        Tue,  2 Aug 2022 22:49:26 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 2 Aug 2022 10:49:18 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 2 Aug 2022 10:49:18 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 2 Aug 2022 10:49:18 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+QEbOqEuPWuvcDzGJtDuCSJ6zegXqw9weg9bEvS5XpBP2aMKwlEgdBq8blsBEQEASNirD4Cn7E1Jv+Zp1K/0SuNI7obtIsRX9nUU0UIMDV+sm2RIBMDjAbw7eKbcR72vGtexIK6btqUpYSZmdFZo3P370UbI/vB1jHOp1GQeVB1QsheaiQKPsVz0ZAf0rgbEnP6NPcLTKstIFskjcwcOLrhoGRCVgcPvJYq1yAt0/mmv6u1wYQoRlOFSph/NIH2zL7iXIl/KvxNMqa9VQ5+1nKZI+fW5MtzMhAHwoWnjdbvKEeJlHP76kB8WjIdmokjUPDPYwRTeL9OMXOkhEP54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBcwqy5rVuadZreo5FWlVUOrcn121dA1tLTMwt/VlW0=;
 b=XLthTer3k7UNC+re8aeAP5f45nmCoQbpc7wn/6vTo180kw/K4z1ZD8d+4+QkfvRo5KTm604xc2Y2OMgswv9g6U9ZhO/oWqB5uwJTDrGscwWKtwSBmIq1tEU+q0viEL0rdh7heDezPaUKGqpTr677uwS6H6y0G1hDViWUhhmZB5NxTLn5RRS3JF/qMx8w1yRoh5wONWVe3N03/Bk4FJj6Ib1mvwacMgtCU6ZLQZljXLr10kPmpg6K7dAVxiZjXn7PpWfBDzd8Azskh4b/4bK+UYCF+Oei2ft2lFjrehLNtOjxeCrmTpK7AwS0jBsHQOU2dpPD/B9iPS2WDpDbudJfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MN0PR84MB3072.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 22:49:17 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%4]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 22:49:17 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "'<Vishal Badole>'" <badolevishal1116@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "inux-clk@vger.kernel.org" <inux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "chinmoyghosh2001@gmail.com" <chinmoyghosh2001@gmail.com>,
        "mintupatel89@gmail.com" <mintupatel89@gmail.com>,
        "vimal.kumar32@gmail.com" <vimal.kumar32@gmail.com>
Subject: =?utf-8?B?UkU6IFtQQVRDSF0gQ29tbW9uIGNsb2NrOiDigIvigItUbyBsaXN0IGFjdGl2?=
 =?utf-8?Q?e_consumers_of_clocks?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBDb21tb24gY2xvY2s6IOKAi+KAi1RvIGxpc3QgYWN0aXZlIGNv?=
 =?utf-8?Q?nsumers_of_clocks?=
Thread-Index: AQHYhlnsnUQ3P7E53E2XSWzjiEGgZ61iCBkZgDptc7A=
Date:   Tue, 2 Aug 2022 22:49:17 +0000
Message-ID: <MW5PR84MB1842824E0F57D0EC46381B09AB9D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <CAEXpiVQihEadxsNodarz2-wxSAipfpzEaA8zKpnozszC+weYTQ@mail.gmail.com>
 <20220610194013.DD39DC34114@smtp.kernel.org> <20220622170219.GA6978@Mahakal>
 <20220624010550.582BBC341C7@smtp.kernel.org> <20220626182517.GA26001@Mahakal>
In-Reply-To: <20220626182517.GA26001@Mahakal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3638ea31-5579-4513-b5a1-08da74d93ada
x-ms-traffictypediagnostic: MN0PR84MB3072:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDUYV0SV+bq/asY2nbAhXR80tSJMcxmTe6detlxBaWyGcMtJhwe3vYXlpL0E1XebtVm0sbIYTAm9WIo+0aI0sbkECb7l0VC/jNif/BwH9j7/DdP9NbGI2lcstL65/Qbii3h2ePs7NYUqAVSsirRN8JIShqXH41MQUEyiNbomCT8N9Wi00jlXtsduhqLjxBKxqnp5Nj1dZuITT0DZybOdjRev1dqCxDKuTTS3H/fe+57gtAkwTzCd3MDqvr0Z2+CBxFhomuXzq3nLT/vOBedweAKrWwqo9915Z8AyOMiAg/2JGlr6HcuYCzXdi7OzmoZKgtjbtUjigSyiaVviaB/RNM9+Y9qCff7bVlevEUsQrh3q8/ICOv1xBwo7vsaIW8yCJh91M2Yi+FAENdA4mpNhY7ys1R+7r0kiy6Tfkjp8DrMSHAxt9YsLql+qiIp96PM6HSvheUgailQ9Wd3huYkQjLgCoAt5zWKH9EEqu+nBfxQZu7g8+K+GEE5V5uLBsdJMWSco3gcXTkfB85cjfOuvDosFHM00XR7+/FaBscCrVs/AWtAXnWDlaq4dlrnKDxtUAKY9+7q902HMZEbmuSFbX/C6XZJ7auE/Y55MWJrVuaPGs3kIeHClgi74LASPWF1DIOQlsdlnWIH/N1UuotWsCDy6ppGMuGVUS7A4nu5173vBIfC7/mf0s2oYEAvBpTXp/4OY6sqDwJH/jJnYBbEx4GooOSL0LtvO9Xcjd9zxldMWt63EtZnztYc7MSYYf2Ts3GVnj1fyWbRwf0/XsOnDyLZicDAuRN2dm5GniN5QJew=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(366004)(39860400002)(6506007)(53546011)(7696005)(41300700001)(26005)(9686003)(316002)(55016003)(478600001)(54906003)(86362001)(71200400001)(82960400001)(122000001)(38070700005)(38100700002)(186003)(83380400001)(4744005)(2906002)(8936002)(66446008)(66556008)(76116006)(66476007)(64756008)(33656002)(66946007)(52536014)(5660300002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azVtY2VDODByMmlGeWlnM2dIdmh6Nmk4UnFBL2hhK2l4VjZkdHF0U2daMFZh?=
 =?utf-8?B?SXpWVE9WWUFhQ3E5UXFHMjkzWkFrWVE0VVdnQ0hFSjVFdEFoRE55UG5zR1E1?=
 =?utf-8?B?TjRZeDRXMHRjR0pTQm1VOHNyZWpqTi81OGdUTGQrWnhtaUQ3Mzl2SGlsYU1v?=
 =?utf-8?B?am5qN1QyRFRQaEVVMUJMcUlRbmlBSnQ2RzVuRjRDR2JOaGtRVE1DdnVLaHdv?=
 =?utf-8?B?amM1S3U2RHR3YUdtbDlEeUVSNDlWb3JOS2g5TTlLaTRtWTNYY2dhOC9uRVkw?=
 =?utf-8?B?R3h0bmt3aDRXdlNrZkZhQzJXbmpJaEVTeS9rMkcwa1ErZUxMSFI4c3ZBcElE?=
 =?utf-8?B?dStuVjVSRUhIS1ZmalcrckVmY2FIWjgvRnUxZm1lakZWR01HekU5RmpMNVBp?=
 =?utf-8?B?WlZINWQ4WGVuM0VGYUpzMUFrZVNCdWVsVm1NcFp5TXBiUkk5SFg3VlMxSUFq?=
 =?utf-8?B?T2RZTTBJd2JTOTVrdlB5VlpCN3lwMUZTTmVNN1BxaGZlVEhJdzFsNmE0OTFY?=
 =?utf-8?B?VCtQaFNVb1QwRFd3Y1pDTkpmTHZ0R0RmWkpmMlV4QUl2S3RsbnlPS2oyaGZk?=
 =?utf-8?B?eFJ1LzhQbHl3MkJObVl3KzZ6M1RpTTJHWjJXd2FDaFJLOVJDL3orM2orWitQ?=
 =?utf-8?B?L3dRVG1nNHJCdGY4U1FZa1JZeTVPaXNyUTlRRUlnREJvYVJvbmwwQ1VqRnlj?=
 =?utf-8?B?ZnZNK0ZES01YYTJXNm1DRG1aMldiSE9XR245VWM0Tldaa3A4NkNyS2txenlZ?=
 =?utf-8?B?R0RVek9obWVYei9YYXlndEFDcFJRelVYZVk4bVJNMUkrMkFHSUljNERFUkZh?=
 =?utf-8?B?K0dxZEhDOXJNNTZsL3U4YXBLUC8vREdXOVJvWTB3MEdUWlpiOVduNTJWZzYr?=
 =?utf-8?B?a2dQMzhxUnowaTBEVkkxekVQS2dxVmNSUlZVaTFQbGtrS3VwdlozMTBrOTdQ?=
 =?utf-8?B?Unh4UXJGUFRMZ3p0a0ZwRFF4Z01kK0RnNkh4aFEzUmMvWnUwdHhYVkpWSG9o?=
 =?utf-8?B?Wk1IRVJJbHRyM3RBcGlLN2Fjck41dEFzRDgxRFVia1JNM01YTFhiYm4xdVl5?=
 =?utf-8?B?NHBHSTBzSHhsRWo5ZGtjcG1ZcllidjVLOUszbjBjUlluQ1VQa2NUZ3ZKZ093?=
 =?utf-8?B?TlAxamZMZnl1YXYvY3EyKzVidm1Cdi93VGZwWWFSRGJONitML2t0N3V6SUtF?=
 =?utf-8?B?Y0plQUlEeFA3TzFZdEtDclR3TG5wR01GWnh2Z1ZsbjE3eFZXbEkzbkQ0Y200?=
 =?utf-8?B?cmR6NHRrai9VcGwzYlYrVUxhSXNJRnhMU0R0cTZYc2EwUndqeTdwZHBxQlY2?=
 =?utf-8?B?bk9wTFJJQzE5UnNoV2lWU2VMbFN1c1Y5bE82OWY0bVBNRnZhQ2paVHdnYmxB?=
 =?utf-8?B?dFBXeS90K2wzYVh4cmY1cWFYdDdqZTFUd3U2NElCOEgzQmkrNENod1A3aVVF?=
 =?utf-8?B?MG16YVFyaGJXTFlhSk1ZUjVyck8yWkRoV1pNVnc5OHBySGhmRnVVQ2JiaGRT?=
 =?utf-8?B?MlZYMU1ka0F6d2Y2V0dVUlo5TUwxMVorYlNNditOVVhUMGZySmpjYjk3RGRM?=
 =?utf-8?B?L2Y1dFBsRE5XYWVYdFNWWnJURENOUkt0UG9BbmNpNVNPMWNvV1R4Tzk1MUVi?=
 =?utf-8?B?RjBYZkZUN2VWSCtOWTZOVkNobHlpSDdpUDlKY0hHWklpWHk0WEx4a0tPQUM3?=
 =?utf-8?B?dDh1YnVtRDNIeDBuS1JWV2JERVd5U1Y4azZKZ3BaNjE4WXI3TzdnYndPeDJz?=
 =?utf-8?B?emZVQWllQUtFYU1BcVZhc3ZRVXpWaUFNd1lQWGhsTjEyTFA1YlE1aUpqSEhw?=
 =?utf-8?B?RlhNMU0zZk5wZmxzZENaQnh6SGtUby8xdmcxSktFQTBGQkx1aTk2ZmhxYVNE?=
 =?utf-8?B?WUdCcTgrbWR0eEFVVy90OWVtMy9LanZMZFp6YmI4Q0g0d2V3UFJTdEx0VllC?=
 =?utf-8?B?KzB0UlVpMmcwWDJrVEJ4L3VpTjdpWm95ZVU3NDlNLzV0TERvRlluU0tJRzAx?=
 =?utf-8?B?RThGVUkzVktPUnRBR1NkdGZDN2V1aTJybkFiM3dpQ2JjNE42allXdlNaY0RF?=
 =?utf-8?B?NjVuTWwzd2d0MkRFdzhiV1MvTXZla0tqUTJKWktjZlU0UkY3TlMzWFpoYjlM?=
 =?utf-8?Q?lzzE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3638ea31-5579-4513-b5a1-08da74d93ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 22:49:17.0171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZZQc2Pvt5IOsYU37EYeIia7rOgqkvPES5IKxVRy1CiAAF+Pj6fyeKCMQxYauE+t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR84MB3072
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: lo4tTA-65mt5taWWMlMGQZQpzk11olHE
X-Proofpoint-GUID: lo4tTA-65mt5taWWMlMGQZQpzk11olHE
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_14,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020107
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogPFZpc2hhbCBCYWRvbGU+
IDxiYWRvbGV2aXNoYWwxMTE2QGdtYWlsLmNvbT4NCj4gU2VudDogU3VuZGF5LCBKdW5lIDI2LCAy
MDIyIDE6MjUgUE0NCj4gVG86IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz47IG10dXJx
dWV0dGVAYmF5bGlicmUuY29tOyBpbnV4LQ0KPiBjbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBjaGlubW95Z2hvc2gyMDAxQGdtYWlsLmNvbTsg
bWludHVwYXRlbDg5QGdtYWlsLmNvbTsNCj4gdmltYWwua3VtYXIzMkBnbWFpbC5jb20NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gQ29tbW9uIGNsb2NrOiDigIvigItUbyBsaXN0IGFjdGl2ZSBjb25z
dW1lcnMgb2YgY2xvY2tzDQo+IA0KLi4uDQo+IFdlIHdpbGwgcmVtb3ZlIGFib3ZlIHByaW50cyBp
biB0aGUgcmV2aXNlZCBwYXRjaC4gV2UgYXJlIGZhY2luZw0KPiBpbmRlbnRhdGlvbiBpc3N1ZSB3
aGxlIHByaW50aW5nIGNvbnN1bWVyIGluIHN1bW1hcnkNCj4gYXMgZ2l2ZW4gYmVsb3cNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5hYmxlICBwcmVwYXJlICBwcm90ZWN0ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGR1dHkgIGhhcmR3YXJlICAgICAgICAgICAgcGVyLXVz
ZXINCj4gICBjbG9jayAgICAgICAgICAgICAgICAgICAgICAgICAgY291bnQgICAgY291bnQgICAg
Y291bnQgICAgICAgIHJhdGVjY3VyYWN5IHBoYXNlICBjeWNsZSAgICBlbmFibGUgIGNvbnN1bWVy
ICAgY291bnQNCj4gICBjbGtfbWNhc3AwX2ZpeGVkICAgICAgICAgICAgICAgICAgIDAgICAgICAg
IDAgICAgICAgIDAgICAgICAgICAgIDI0NTc2MDAwICAgICAwICA1MDAwMCAgICAgICAgIFkgICAN
Cj4gICBkZXZpY2VsZXNzICAgICAgICAwDQoNCg0KQ29uc2lkZXIgbWFraW5nIHRoZSBrZXJuZWwg
b3V0cHV0IHNpbXBsZSwgZ3JlcHBhYmxlLCBhbmQgcGFyc2VhYmxlIChlLmcuLA0KY29tbWEtc2Vw
YXJhdGVkIGZpZWxkcywgb25lIGVudHJ5IHBlciBsaW5lLCBubyBtdWx0aS1saW5lIGNvbHVtbiBo
ZWFkZXJzKQ0KYW5kIGxldCBhIHVzZXJzcGFjZSB0b29sIGRvIHRoZSBmYW5jeSBmb3JtYXR0aW5n
Lg0KDQoNCg0KDQo=
