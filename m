Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B1E4BC169
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 21:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbiBRUyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 15:54:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiBRUyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 15:54:18 -0500
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEBAEBAD4;
        Fri, 18 Feb 2022 12:54:00 -0800 (PST)
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
        by mx0a-000eb902.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21IGuWlP005428;
        Fri, 18 Feb 2022 14:53:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pps1;
 bh=UfSn05pxi/b7xOMz8V0Lg/VKNdZ8Qzhl8rz6XypW2m0=;
 b=VJcZa7DWAaTkVZQdvqjR5cd3NVaFJ0FmmCB+UzXHCJlE8sOaQAglIkI3hbyR5YlU28it
 rpoGD4e+RJFsuYRKFeaXvdsXKamdhrkoOcg+MPhDp0ic9+U4Zj8ZNsZ5vJ5tNsA6I3GY
 e9A5O1uSUXME52sAlCR3UVP+nE8zehwnpEtbO+uCZD8wnAy5/BGKeWFusoaAdXUvIePM
 fE7MAJHLfmmirABoSd5fUdhJNt9NGLvsGkAwZBAiPYGNWn905PtStiOp2Un0qSNkRxEp
 TJe5oflEkieBqkvN+ESjDeYnC8Hlozx67sRNxV8q9y3EMW6JG/5SDh550SSUnMnUauZf jQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3eabr90s1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 14:53:57 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNpLg0T+8sqFNL3LyIjGsBMsdzZg18FnI+1zJ5k4jj/mKcq+MkcIlTvL/jVQkPHdtWI2th1JRvHSu5Jdd457vXIAREJv7xZOER5QDhWCr2jizWrrNzPjUuzf96MeOGk/zVihkRXp21OScpijOAexNHCYoBBMFhGtN2DopbDjnK11wCi7cngFJOHh2P2gRgw5uZpFA0GhhVUGbKitnj3QonI5fR6j2a5EZ/WxZRXmreJl++XoYWqcCkkgTTi5SBYN86HE9yzZUoz9AXWefUxmaUCC1ApDDzuq9Sj21AgJyrZTn5o2p67RYXRakb/L52xHb/jB5W/vdRrnIvDlU5N94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfSn05pxi/b7xOMz8V0Lg/VKNdZ8Qzhl8rz6XypW2m0=;
 b=ocIVkwiHBFO4NzLIV1VUaBaDS8ilXWhHpJq7cnXwoc5M1m7FwlX1RcXnOgfvNIxBZfSY08jEzbMHH69TDluq2Kd0oMOmoOlrT1Vy1i8s9LDNUpZCebbV6+2vvnfVGdrtvnRhqcQlZCwBgRX8TvmtP4mOQ4yBbsjF+UcFBZKOMLDNTCXvgxqfjyaJjc/I1uUjRYxBAnyo40h2t/nRjJbI4r4xYnuHTL5+dazv3JdEq2GXalcGZ4muL6w0GPQucbuV5C0GkhRuw+aRueb+I+By4opQXaI+W8cLq/GNFhRxuax2ag+9UvNeDD3QgZLz7ADaKWs4DE6GSffnXi73uOqLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 204.77.163.244) smtp.rcpttodomain=gmail.com smtp.mailfrom=garmin.com;
 dmarc=temperror action=none header.from=garmin.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfSn05pxi/b7xOMz8V0Lg/VKNdZ8Qzhl8rz6XypW2m0=;
 b=YvOGeQP9g9jRiCA28T2PEa9bjSfSkzNCl0nS9k6kK0RNtJYY74TexenDrbSsoySJCsSIO2Ozb8165SpMxhQSfHPjpSHL8dQOW7mP4d57w3vC28LlDRaY3MEIo9M7ykeFsQUxO2MObbyxzx/bT0qqhyD2i7O7iA0LttF7ABNcWe5PChw3g8+SMTVCZbxsEk3sZPsHt2LqjSm37mNRdtbIk/ZgEDlG++Wcje+jRiDWMu627R+Pu7XGzeFcAUIT57VWNagrxT1yrQd4zZCC+Y0jPHX/E+yoeGdhv8SY1fXVSE5tCKVuVb2TJ8vFPC/UOfNZU1yvmBR4wsBE+3XbBYkLZw==
Received: from BN9PR03CA0481.namprd03.prod.outlook.com (2603:10b6:408:130::6)
 by PH0PR04MB8324.namprd04.prod.outlook.com (2603:10b6:510:db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 20:53:50 +0000
Received: from BN7NAM10FT067.eop-nam10.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::c4) by BN9PR03CA0481.outlook.office365.com
 (2603:10b6:408:130::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 20:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 204.77.163.244) smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=garmin.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of garmin.com: DNS Timeout)
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN7NAM10FT067.mail.protection.outlook.com (10.13.156.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16 via Frontend Transport; Fri, 18 Feb 2022 20:53:49 +0000
Received: from OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) by
 olawpa-edge1.garmin.com (10.60.4.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 18 Feb 2022 14:53:43 -0600
Received: from [10.30.196.25] (10.5.209.17) by OLAWPA-EXMB12.ad.garmin.com
 (10.5.144.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 14:53:48 -0600
Message-ID: <2a34020c-008e-834b-f341-4ea03b83e31c@garmin.com>
Date:   Fri, 18 Feb 2022 14:53:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] input: Add Marine Navigation Keycodes
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210622235708.8828-1-matthew.stephenson2@garmin.com>
 <20220126211224.28590-1-Shelby.Heffron@garmin.com>
 <Yg9EmVAHpEpmnLok@google.com>
From:   Shelby Heffron <Shelby.Heffron@garmin.com>
In-Reply-To: <Yg9EmVAHpEpmnLok@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: OLAWPA-EXMB1.ad.garmin.com (10.5.144.23) To
 OLAWPA-EXMB12.ad.garmin.com (10.5.144.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d2233c6-c8ae-4d5e-d72f-08d9f320c36e
X-MS-TrafficTypeDiagnostic: PH0PR04MB8324:EE_
X-Microsoft-Antispam-PRVS: <PH0PR04MB832433BE5A308378CFE8FA02F2379@PH0PR04MB8324.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDQl9S16fj3VkAzOKqOm5TF/EWpYWMtF1IAD/IjkcVkdJ0Ou575EqsdJml5tD+Raaj5P5ZElk5rckXo/l8jWM1B5GxoMREi1pqrFqhegj6BlVhzDUxBQ6jT4Oibi5norpXvJHGglTnfk9QML3OItSSNt7RKJgHTbdzWsakf54LSlR84VjkjlfsNHY1wm8NUDje5uiZpHr/xIQLvMUXs045LyfKyqvzu70VzS585sdkDAR6lxptUWIryagOVdBJ3/8h/8TCSinv3bNsjweHTv2djIkekyckuu9qHXn2zCe8A96AjkLwU6jNJcbnAt2J4HtbLT1B5XdU4y7+t17E6T9DWSR/LV+z+q7xlx4wD9CxoNTQ3rgXGfMGRIBwzvE/0C4Wi+ceUM2zGJaywGTN0NRpWG50o6IbnfOosOUjNOSKDr7XlhUyOk8OlpmzuMj2zmMRcm5f4ejA82O+6XRePjfaQzgJZqr3+xRV/bZG+YcBnJeNC0+4/+PCyiIkTP9YsHckgvDZGj/k8lzNTYFkRMblMCbwlPUqsDxmywg8ps20c0qJyA3Nt+MqV7LPAK3NW80rEH2XGxyI9V6MiS6wKGjlo0xljRKDCtn+mdR6eWFLaiCzWsk2zdxYZZdO6ZqGfejdRR1emtM2WvzVVLwEYAxSOIyY5xZY31qfYiS/5orodHdOq9fU9PC6vlbeu2GrdHMzysOwXhFrPbXyHdXhM8NA==
X-Forefront-Antispam-Report: CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230001)(46966006)(36840700001)(40470700004)(31696002)(47076005)(63370400001)(63350400001)(83380400001)(508600001)(7636003)(356005)(40460700003)(36860700001)(82310400004)(36756003)(426003)(70586007)(70206006)(316002)(54906003)(6916009)(16576012)(5660300002)(8936002)(86362001)(8676002)(31686004)(4326008)(2906002)(6666004)(26005)(336012)(186003)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 20:53:49.1866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2233c6-c8ae-4d5e-d72f-08d9f320c36e
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7NAM10FT067.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8324
X-Proofpoint-ORIG-GUID: kBIvu6o5x3UUi-MkGjmAlv86T4TMBr7W
X-Proofpoint-GUID: kBIvu6o5x3UUi-MkGjmAlv86T4TMBr7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_09,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180128
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

>> +/* Toggle the focus in or out */
>> +#define KEY_FOCUS_TOGGLE            0x27b
>
> Could it be served by KEY_SELECT?

We have found another keycode that will serve for this. Will remove in
next patch.

>> +
>> +/* Move between highlightable items */
>> +#define KEY_NEXT_HIGHLIGHT          0x27c
>> +#define KEY_PREVIOUS_HIGHLIGHT              0x27d
>
> I wonder if KEY_NEXT and KEY_PREVIOUS would be suitable for your
> application.

Yes, those keycodes should be suitable. Will remove in next patch.

>> +/* Navigate Displays */
>> +#define KEY_NEXT_DISPLAY            0x27f
>> +#define KEY_PREVIOUS_DISPLAY                0x280
>
> I am not familiar with marine navigation devices, could you please
> explain a bit more about displays you are navigating. Are there separate
> physical screens or are there several application screens/views you are
> switching between?
>

Yes - these keys would navigate between separate physical screens.

>> +#define KEY_BRIGHTNESS_MENU         0x28c
>
> Do you have multiple menus in the application?
>
We have found another keycode that will serve for this. Will remove in
next patch.


Thanks.
Shelby



________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
