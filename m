Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0064E80A0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 12:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiCZLrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiCZLrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 07:47:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2033.outbound.protection.outlook.com [40.92.53.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F338C5044D;
        Sat, 26 Mar 2022 04:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWqhRkXSo+oP3qbWI3cR2rlScWAm7rfFjVdlYSk5XuVHwL12Yba30n3UCv+0K1MCC1mwyLxuNfGReovY4lbghLMPaxnAuCzA+SiYJU/PG8e/PAviC3+nxnQfpFYGrGdY79MTcfL2cT95Nga9MccQnPzfobjJPHl/husQNjnOKMPqtyZrkiSd9ykaeFU9Bv4jScLcfZJvm+vrMOU/a4zttgFE1UIE2SeNmSplY/ddJp2cu+KCp1qv/kambLADwAT5HWiUvDlADVSh3eRvMbdoNYAbclM+rbQbikQ7AeVN2tQpXPuiRxjNWnRA2BTgP6htM0TXCLlyE8V0k0tLpc9SFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
 b=BvFw5UxNDqBhKPc1RMKVtTyQDbOCxrp6du/oQ6tLwWQxFlpGg+2P5VORgvgZzxU0ZwFk1ylwx9Jiy1k0iEs6OxcdaTuFsb9V13gnYBXCqtmzWknqJCXsi7b5ePPpO4i8s1CMirFb8ry8avemo8JCsmj8/9SdQ2tj9bdVXv1YSUka0dZ3mU2/BxuCqF6h+ejsY/9sday2waVN69s1a5oITY98eqL2Mk5bJIOuGiCyInGWLcf34x7MOhf+MxTTCfiWysgByV9SCTzJdPD3P6fzfAxpr5/1DmCe7gwZqLFy/sxC/iGaBzQhIlq+I1M2nkZoOu/N5SxpTJsz6rmd/WGc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
 b=hjxvWUn6bGhMky47CgB0umFijQNAN7lN22XPrTNgSWeOGyjstQF86/fsj8SwvmjLgVzqpSBwpi3k/A0+sy7L0UAxOPurmapEnJ9lXubwa9XV8syaTkJ+oM/F4d6voT94cUVOCQm3DKh2YaYN1sCS/parmjeaw8dKlIMb1IEp55bGIFii8CJNtMPxklThbFpXpXSXOaB+XTkEkDZzo58Bk5ugvGcKJoWiI9aoo7RjI2voH/QM5IZWP3/QZvAuAbSkyzDvtGNszsRcZHNsJBtdEoOEVG8Orq1nzi1G+j24m10Ncc0mPNd8w0JP62CZtQl0tFmCZ67XvHYgZIDFpEjgSQ==
Received: from TYZPR01MB3935.apcprd01.prod.exchangelabs.com
 (2603:1096:400:8::7) by SG2PR01MB2061.apcprd01.prod.exchangelabs.com
 (2603:1096:3:21::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Sat, 26 Mar
 2022 11:46:03 +0000
Received: from TYZPR01MB3935.apcprd01.prod.exchangelabs.com
 ([fe80::8dd1:e105:311a:ce51]) by TYZPR01MB3935.apcprd01.prod.exchangelabs.com
 ([fe80::8dd1:e105:311a:ce51%3]) with mapi id 15.20.5102.022; Sat, 26 Mar 2022
 11:46:03 +0000
Message-ID: <TYZPR01MB39356D38FACC73ACB99B47BEF81B9@TYZPR01MB3935.apcprd01.prod.exchangelabs.com>
Subject: [ PATCH ] Documentation: fixed some doc-build warnings
From:   kushagra765@outlook.com
To:     linux-doc@vger.kernel.org, corbet@lwn.net
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        balbi@kernel.org, gregkh@linuxfoundation.org, dhowells@redhat.com,
        mcgrof@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, arnd@arndb.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-cachefs@redhat.com
Date:   Sat, 26 Mar 2022 17:15:50 +0530
Content-Type: text/plain
User-Agent: Evolution 3.36.5-0ubuntu1 
Content-Transfer-Encoding: base64
X-TMN:  [2essGCoMYUavK24/KHylj7OZS/k1rlk3giwXyI4m6gM=]
X-ClientProxiedBy: BM1PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::21) To TYZPR01MB3935.apcprd01.prod.exchangelabs.com
 (2603:1096:400:8::7)
X-Microsoft-Original-Message-ID: <2f72251802e01eb81e5ef71e16b55f71728a0a5b.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 939fb3c8-71c9-4d2f-39b7-08da0f1e346e
X-MS-TrafficTypeDiagnostic: SG2PR01MB2061:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CY46gVzwVdWJBqm9rKtymP4igUWXQfhNJDKoKpItVrrYmwAHBrXKPxArzjSQLhZh5XIuZe1LMzkEGCU26r6RRMHmAGLp+heXXCyLP2aErN5ql9PBhlHNTaJa63m3XCexYgDpk852uNtfF4laLhq2GOUVOhOJYC28fDrv9ANhQTE4yJ32rhvhrMLsi/vdS93C+7/SObqNPWE7Q/UbY4QXi3DjiFKw2cXs8y/4I+fPAXMV8uJa1RiH9bB2ApeLjvJ2pYBKmIJnb81XlQ7mN7PrOP36Y1JbyE7SARum28kqrIOYj9qLohft29c+VL9b1Qc5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?60JgILX2rR0fqEQ8P/HL0e8Oo7D9h11fb762lcww7FwPQ27Qr4kh2+JVlyy1?=
 =?us-ascii?Q?wdPv0htp0dFd50Rnmb+D4Jpt0fIS0yZVSN0o1nKcTdlrf+RcxMXU5Y7SH7Ap?=
 =?us-ascii?Q?6PnYq16gk4/j8zmH4mx2PGfBQWqrnJXqANFOvHQ+cxkcQM7Lb8/iWIo0htIe?=
 =?us-ascii?Q?KXOPY68zUoL6UMzmCpgIsEU/rR23uyP+c7PcpZsQ3qE2PSTe3PeMaS0pOJWw?=
 =?us-ascii?Q?/m03Hb7MkKR8oThVEqtKbl8yF4ri82BR+vQiTXt5AV4RYetfZzxjtxjO1v/Z?=
 =?us-ascii?Q?qQ8lhpJSTG+m/Rwv+qkqjPi7y2040X8PN416e74Y+AytoWVpuJlevfuiu1MF?=
 =?us-ascii?Q?EkeagogTN0BwBy1iIOsP08mOpWKrfDs8TH+xT7AzWQuj7UU7kb0dxEW8yesQ?=
 =?us-ascii?Q?fCTfDvmHvfeYjb2G6KyIUxS7W+Sb9F63VXH8kz72/xGCWEeBXvXwTe1HHBdT?=
 =?us-ascii?Q?bd1WnJmiHVL6YwNocVuS6FD8DMjC/R4q3FvW/9XWHCYNB0jLGJgoAoxK4tiF?=
 =?us-ascii?Q?mukaYpQoxxhBqOFZSlV1Jkt4Pm1Wzd0vE55qTKlSiWRfiVX8QmCD+Pklpn48?=
 =?us-ascii?Q?Ik2NUlrDMG2Fzhd2TZ5MOInHUele1LbI4eFjJ/8Iga9iWqbj+VfkiV97H1eF?=
 =?us-ascii?Q?OwY+uDZwLSWUCtACCuyKP/iw4Hn4x6iOr60iP0Z10Bpduu3e7yT2pJ6RGWUR?=
 =?us-ascii?Q?AamkSszZAJDJoXS5fo29WXjmd1ljECjhMB05gmHc6vWERMgVbKe6q2AXc2QD?=
 =?us-ascii?Q?MbO8RVayZCGgRyPZfUFZ5fEiXXeRYOulYSLVBxE1of4+DZfPf7OaJpxTkvS1?=
 =?us-ascii?Q?KfzFox9hbmq2crifs7jhUgsLCL2tCSa//PkURvBM1ZbDz41BgdAoHbIcOJ7Q?=
 =?us-ascii?Q?Ghk+cd1KzRUJgQjtFV+3gG8wtpL3FYsbGa/ETZpHkoa4BR4+q8mExBKCQRQB?=
 =?us-ascii?Q?uyyni0ZbAqxiexj53dOJoyF6W49X3RRWOYMdRw3l486J60eldcMuht7qFXlj?=
 =?us-ascii?Q?qBZl71UbJZqgBo3QTF+fn5A7lKdUQwOtv87cGoAoX5EwL6VlhxPGQUNADpAz?=
 =?us-ascii?Q?JEDzyBmbbZvRpIAb25ZaGQNOAwXq5q2Dxv5lcSAigmfPnno5ABuMHT6qRUfn?=
 =?us-ascii?Q?eG5dFoT+aCKGlU2tIKwQ8AKBlRMuH3M1ZzbrM68mvtHIhMWTlSVPWgurZY6F?=
 =?us-ascii?Q?diGJOGQbLZGV12+rYz1AqqejGRFoJ1cJS/5rodxrG/phDNb5jWeBhDHi8v/B?=
 =?us-ascii?Q?UPdU2Rq9yiiu8KD7dx67hxFzMKBIc99Lf0G+llFhnhIwgxVInndz8bksJ/qF?=
 =?us-ascii?Q?ThUdoZY1G/JDGV/vphjo6IRVr9AtHyUAavVs2DKtyx9NgDlw62WeqoYVbEYN?=
 =?us-ascii?Q?/qaykQjntHLcpZ1whmVM4+Zd41uh4x5fNdq6USo7Iagx5wrddpHWIjuadZz8?=
 =?us-ascii?Q?h470LTZX0aUNLD12ze1nYsx4KV97tx1G?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939fb3c8-71c9-4d2f-39b7-08da0f1e346e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB3935.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 11:46:03.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2061
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,BODY_EMPTY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo=


