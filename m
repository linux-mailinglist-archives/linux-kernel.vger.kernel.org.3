Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC09571706
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiGLKQj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiGLKQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:16:30 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3E58AC055
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:16:29 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2046.outbound.protection.outlook.com [104.47.22.46]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-EQpRHVZBN42z8RkcWOP7Dg-3; Tue, 12 Jul 2022 12:16:26 +0200
X-MC-Unique: EQpRHVZBN42z8RkcWOP7Dg-3
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0165.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Tue, 12 Jul 2022 10:16:24 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 10:16:24 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Input: touchscreen: Minor colibri-vf50-ts cleanups
Date:   Tue, 12 Jul 2022 12:16:17 +0200
Message-ID: <20220712101619.326120-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MR1P264CA0170.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::18) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a2e06b-746e-40ed-876d-08da63ef9365
X-MS-TrafficTypeDiagnostic: GVAP278MB0165:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: c9+iiZ3wXs5CIbU8dZhJlDkmUpvM2wuOkiDcgmJzYtaiCz6bsNHXQeh2fJbV/7Ahko28q+P+cMyTQsAAYJ97nul+IWrY3ggKRyhsusEtXM3wbUgdIpB+4V+/12sivvVIT5lS10sEMpu1mCjpk7wvQr6GUSGDDbVQSRnakGI++DaMU1t/5m1JtUV1sXCB/M4sA2ThNizNEF1ecTB9nbxUbReG0JcxtCndgOALWIF1LmNLvGRnPUTTjYxLQoerWRVR5Q/dfGSxHUOBxDjym5VjPeWUk5GUOjr6f89yLzrRShSzwTRG3+BUTqeQEguWPIdh32VwuiyUhX7z3oJZ/C0RQjt216NCtcZTh4QtSF3O9EEvzcgQU+wM1rHZ3dBEtd8+YFhUstZl+qghEpy30e7GiLYwbaj4MFDSGIWOluGF4CcQ5RAQph+yjYwzW03NE2O0erOUvFaDUp9OhsAn99PcRHAXgLSkcZaPRpu2WWUQBo3yFDr7AeMOzNyysrl11+J1Cru29VYBlsenFK9plb88g2CUkVsuMsKYknh+tVOghj32pPRWmuYvCLUMMpNo/pJI4NoynioFFPxYYr2l3nj5AK6pmksl2gDvHF0ep0/D3Bed9/RF8KgPQdaW6EiR82lwb0SwWgoNXylOwJTSFBKXxlVDZiwbHuSeAA0ZIIVv+X9On/CgcXXuxm33I8EC72zchh49cWMzBOFPGWZeHizJXqgqSDQUbTMpZAKf4SyLZhycBW4cWqHKcfxXcadtkt4y4TLl6zdQ5EjMx79igxB4Xff2pQYllgh917l990xVVZk6t0h2mQG5DPZM85Vk54J7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(366004)(39850400004)(136003)(5660300002)(4744005)(8936002)(86362001)(26005)(6506007)(6666004)(6512007)(2906002)(478600001)(52116002)(6486002)(41300700001)(44832011)(38350700002)(38100700002)(1076003)(2616005)(186003)(36756003)(4326008)(316002)(8676002)(66946007)(66556008)(66476007)(83380400001)(110136005);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gtzv/B6CnXAwhEplu6ylbMm+ri2/m/3AiZQut/d1rtNhS8PAyuqrr9IG6+GP?=
 =?us-ascii?Q?BVIz7q3fTbEvx7ArT0GkWky2kCibAisV/dHOjd1d6i54b/O1ymn1OQ3VG7ZW?=
 =?us-ascii?Q?7itgsM6sAilE8hob/KrTI1RUlivWN5stS9mDlole6BidtVp2pwwqkwg1u5Sw?=
 =?us-ascii?Q?mtj817Wvfk4V+g8DVUWrYXrDj3CcsJfvLu1rIrCT5jTz5CjGeU9F3XpW/Zol?=
 =?us-ascii?Q?kZHVwOcBU2ZOSehv0jh8or7rYldIJKw2i1uV41jtFCuz7jRIwmneeltwoSn3?=
 =?us-ascii?Q?R5N8mxDktZRf3iFHLtfMJVHJwipzd805oqQZtWq3ABewv+R94jpoLURcL6eU?=
 =?us-ascii?Q?IjSIZUdrl1Ep43gulstv2CsBqztICQVnjBQmTq48mxoUO44tpjLRZbFxw9i8?=
 =?us-ascii?Q?dtJUhL1M4mQuSwJWkYdG8jhURbSpgQyqgj51lm2AzNayQVREqGfDzE9oSPJM?=
 =?us-ascii?Q?kUCzTPVrc9NEDDPzc4+qKAWwrGUFBl6cTG6bHgUpC3ZbzD6Ur5tD+P3FA6FM?=
 =?us-ascii?Q?PQltKkSMeAozDVyR0LpUvjyICI1Pysy3Oi+h94kO0O+bztwiWlusu/PxIMKP?=
 =?us-ascii?Q?9HENJYrGRoy1xRKHuiDzdZXBKETQ8AB6Ux06Lx7MChjvW/uQNYIHxVQ6q9fW?=
 =?us-ascii?Q?4sIxjj+u0VC3Ev6FdtaxSDF9iPqQ2Q63n2kufPo57wRllnSyFhjFh9g+kmJ5?=
 =?us-ascii?Q?ZOXtFZrEYXmCUP9gQUuRQQQEI6tSm/gnIEA2bIQ03ZKR6kGG5mPss7dDmv8B?=
 =?us-ascii?Q?0WwHy+2dvt/2dCIlKJ5EMAlFcq+kUi9rNmSy5g4KjWQDMn5ofmZLo4+6d7N0?=
 =?us-ascii?Q?u7kKD4Dz9Urv10JOp+bpYOVfQtfhoRdNlJclFrkHN2XLB76Tpr64+T6hSPFi?=
 =?us-ascii?Q?YBV3apJjZmsT10ADJ8emiAMTN6UIeMeMaOncbp948gDP3YckTF1cY88djWby?=
 =?us-ascii?Q?ge3dGJh0Dat8ke17SwJVp+wwiUDKch1E2WtZhdYIudoUabh0AO9LFQ7EQP3b?=
 =?us-ascii?Q?y+/wN7FuISi3YL2ke5T7qdTlF1zSRosjthn0QTXsm9Rwqar6iP0QiZx/ZGeR?=
 =?us-ascii?Q?07N+mue9tM9xfeJTiaVEBatmkBh9cJte1tCvK9Q+dP5Ytfqopuuj+abwN9ZS?=
 =?us-ascii?Q?/v3YaKPt9+tjYFpG0Af50siiiDElaz6KI0OZos3WyBaKMMBngXWUG5Y5BeU/?=
 =?us-ascii?Q?KAaVOdWHh0HJuKrtgkLw2WAU6yAqVykRd7alRvy95pGnuvL7aRKaHJmIbJr+?=
 =?us-ascii?Q?Qp8DS3+KTpx/3oj6LHE4YMXI2knc9eVh6VgJqt4Fzo1BrQSFWBMzLx3qf6sv?=
 =?us-ascii?Q?q8FndZbjtnamyoTyCznr0yVPhqFFzkBufCigiq6mOftZtBK6C7fBxpx/IFr5?=
 =?us-ascii?Q?jemn+ilze0/DYMIfaBIx3sMBd+Yu4RFSYvhCnRd2KaEUQXbx3STASXSRWoJt?=
 =?us-ascii?Q?G+atdob0QNAcXv6KuxnICHaXoY+S8Vz+Gf4DN7bGC7GR1ToNXv1/LlNKW/56?=
 =?us-ascii?Q?eoKVINRx7eCXGDIUxVAcnxdVED7HSuFPRmkAYM7tZIJdl3vfcXZPVc66vmWE?=
 =?us-ascii?Q?5Jdno/z61J833GDaowIs0DejZtcaU11+fy08/hzBnVi72yVGkemkQnKeOnjb?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a2e06b-746e-40ed-876d-08da63ef9365
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 10:16:24.8209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30JoF7TlfCRj7RyLd+pXXqxhPTgY6PDYVGkn04MyIcgm5+cO5jTyBznwQ5JAP+Mi6ia9+jK/FEqLX7yEvW4lxF0L6QtgidLEjtLw+cHiJco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0165
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series introduce some minor cleanups on colibri-vf50-ts, allow using it
with any IIO ADC input and fix a couple of mistakes in the dt-bindings
documentation.

Francesco

Max Krummenacher (2):
  Input: touchscreen: colibri-vf50-ts: don't depend on VF610_ADC
  dt-bindings: input: colibri-vf50-ts: Improve documentation

 .../input/touchscreen/colibri-vf50-ts.txt        | 16 ++++++++--------
 drivers/input/touchscreen/Kconfig                |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.25.1

