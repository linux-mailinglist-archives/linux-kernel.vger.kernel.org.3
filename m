Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE734D68E0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351020AbiCKTGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346271AbiCKTGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:06:54 -0500
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8933131139;
        Fri, 11 Mar 2022 11:05:49 -0800 (PST)
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
        by mx0a-000eb902.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22B4iq1c008510;
        Fri, 11 Mar 2022 13:05:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pps1;
 bh=NwGDYo9/XKtK4X0zKOSLnJiGDCMkkmt0MOXuyyvt+8s=;
 b=vQm9p/LtH945qViNtkSffI51uYnMltA60jADhjISd16pKGP061iN6QL5cz0DtMTruc8H
 E88J+DQtUc8qSrnp0zLDG985rI3FMgfT5BhWopt8UtHKP9AEaGbhqAPD+QhpqWxt/Vc/
 3C/Z/IMLWE3Fiv+PRQuPomna27gVHw6tWr4/VWvLAOKmpBAI2VXL9blzqdDzSxZcVy0R
 QPB/s6ALRnsT1/2uzcN71u+S32FVHgbvXKT+U8mEjw762F5nQsHKYHCg6Tuk47NsvXhc
 Fqy7xxL7Sn9rUt/0wxU+gvpLMqxEP5x+5fJE2JqGSKsZROzixZ7vKIB463eMZUl6tBuv kA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3em6493nhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 13:05:48 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je79EiXVzNmu7AS8SCE07hFnyo/QlE9+9UQmBvNkcSRUth85NyMLHD/A+OIMS05uA6lH22/iaHb8ceVoYC+qlqilRxgBcKUGIf4knfjPcn3ZMU1A73a7MajOzBRku48R2zABeMD9GKtodqfGTfYkySV5kOXdN8lcjITVCcPnUnEYVi3U6L/GIOu9GTq6aOcDj7duIjaNFD2cGaOpdJEdbcKalCeRA2dE0KXGai9m2oQQFY7SWR5YNIEqCjpyczqmu8PkI36MWX9H9W3uvYccJ8Nss4cTaFr1KsrGafIBlgzinvMDNBb8+AIedoLBHryDZ9waQkTAW9h/FH8iqFRtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwGDYo9/XKtK4X0zKOSLnJiGDCMkkmt0MOXuyyvt+8s=;
 b=LvOIvMZ8xiDP+vYoIxhKLZwMi4VnRy5N3T25vnaMh/XW8jxrHKsYDULSoO0+wTz2oNZIrFRuYtqVPXkGlmlxkdXgMzu8n9RycKRyBNf+wXasFoRA1i84H/rI3j25a9m6kUwpAo7TeK1jM8WZ0xzhGP/3b23a+0KB5q7rwI6UvJUTgoOq4CXxpubLvV9eZsLtnezLfqXBmMT4oy/cr3EhNvdYg0eD22vzO4xp0FLnTgWE2N+aluJPaHsqlybLoxyeYLIEjQMCC1sYnnhtUipT4Inm2LnqlakschSOzIsFz5ufKwcDhQW17rG9Uop9giKVfrhAByGmWNwrC1WGoSg49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=gmail.com smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwGDYo9/XKtK4X0zKOSLnJiGDCMkkmt0MOXuyyvt+8s=;
 b=XgfrJUngPPGCTYG5fQA7PXpMVtWCls3boyXgynBp6VxWCXAKfMdd8PKnABGYwSAqTOokj0ViG4nSxISheWeQnFwsVGQ5yBM6DJA2BH8l+CU4hXFZu900aaysuoSlkfAQyJCJbV2T1+UDRtumet3eKyW8DfHPtVjjeDAc+AHmJTbMb8WMuSlBrjWPG+gZru755oXWywqbTJgnAjNs3CFk6BMlEqHV9WCn8B5PnSwsXwlAlpBXskoHthC1E8M41fQU9SZ3k0LehHZw1ZqtMsG+XJ3+2iAlBoiXULl+W6272Z4CpMoXJ+n+IzuvYYv4EPQzpA32zzkdi2quK9R+QlHwtg==
Received: from DM6PR03CA0010.namprd03.prod.outlook.com (2603:10b6:5:40::23) by
 MN2PR04MB6670.namprd04.prod.outlook.com (2603:10b6:208:1e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 19:05:45 +0000
Received: from DM6NAM10FT031.eop-nam10.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::27) by DM6PR03CA0010.outlook.office365.com
 (2603:10b6:5:40::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21 via Frontend
 Transport; Fri, 11 Mar 2022 19:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com;
Received: from edgetransport.garmin.com (204.77.163.244) by
 DM6NAM10FT031.mail.protection.outlook.com (10.13.152.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 19:05:45 +0000
Received: from OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) by
 olawpa-edge1.garmin.com (10.60.4.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 11 Mar 2022 13:05:41 -0600
Received: from [10.30.196.25] (10.5.209.17) by OLAWPA-EXMB12.ad.garmin.com
 (10.5.144.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Mar
 2022 13:05:44 -0600
Message-ID: <ad8c9126-b2df-361e-867d-c23a1d7b7ded@garmin.com>
Date:   Fri, 11 Mar 2022 13:05:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] input: Add Marine Navigation Keycodes
Content-Language: en-US
From:   Shelby Heffron <Shelby.Heffron@garmin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210622235708.8828-1-matthew.stephenson2@garmin.com>
 <20220126211224.28590-1-Shelby.Heffron@garmin.com>
 <Yg9EmVAHpEpmnLok@google.com>
 <20556881-1d16-4718-f28c-4a32946d2ecb@garmin.com>
In-Reply-To: <20556881-1d16-4718-f28c-4a32946d2ecb@garmin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: OLAWPA-EXMB1.ad.garmin.com (10.5.144.23) To
 OLAWPA-EXMB12.ad.garmin.com (10.5.144.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0952dcf-4fa8-4534-8ca8-08da03922556
X-MS-TrafficTypeDiagnostic: MN2PR04MB6670:EE_
X-Microsoft-Antispam-PRVS: <MN2PR04MB6670C3D4999864B1F01E20C6F20C9@MN2PR04MB6670.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VfJBDZe1io+x9uGl+Qh4jequxv5gs7eA5OADunSBLQ3DoSB/s5S5kUPaM0Bsf7kG8bQz+iCL7yn11Euf6bxCi6wNd/iG2qOjQqjhDDKNwJrJ57Aiu6fnRCZmsgIILQsSj7hiS1jA0t+jvlMq8atLA0UDf8FLrhGV3TrIFUFn0mUjIdOm8RxPZJJ0tT/kXki5O3/5mxvhoRCgYYXEwL+bv6XMnpCON8u7CeaBrqodum2lku0rI6nv0Rxr9hwJ4eN+BUBWVUH1NdXkb/rQHIq7gJDlutvdpzjl45m/yGGD9AY7yLj0nyf3N5L26qXH2a+ifIDfQJvuvRqmGLnNxgoT26OAYXUvlJS3O1Go7xJUcbLBoh1hHW9p9V6feuG/2stTihqt9zJBPVQjDaQ35ksfC051rcuQeetXAny3xdyN2bS2qfs6a5Gw3xux0QGqqeW6IyUSbOWfErGHEQIt7KntAScfRTrVNFAP4qyqDRAnTgYHD1FEshokxxndIBy+/lLuLr0RH8Tbp5ZQkg7DuygC6SwZfjoh/qEBSNmQN4e9r/f2aDsHxUCEX0iM1Xz4HvLsd6gyV9hNnVbQoB3b4qa9dxr3h6oktZ6fuUgbgoH7dk/xeO0GXtQk5vbh6GbGVgnqAY5pVnn2MWRSK5i/2Jc1kZE6FVUvvxpeh0t7uTNVutw4wqasJ9UHfebF/SQ39nTGfmkLEp+1hvcPW2HmKwSJw==
X-Forefront-Antispam-Report: CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230001)(36840700001)(40470700004)(46966006)(31686004)(83380400001)(2906002)(4744005)(508600001)(82310400004)(8936002)(5660300002)(316002)(31696002)(86362001)(36756003)(16576012)(6916009)(54906003)(36860700001)(70586007)(70206006)(4326008)(8676002)(47076005)(7636003)(356005)(26005)(336012)(186003)(426003)(2616005)(40460700003)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 19:05:45.1790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0952dcf-4fa8-4534-8ca8-08da03922556
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM10FT031.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6670
X-Proofpoint-GUID: EcnAK22LL4Wp43nnkiGjGMwYs7Blxtrt
X-Proofpoint-ORIG-GUID: EcnAK22LL4Wp43nnkiGjGMwYs7Blxtrt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-11_08,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=903 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110095
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Please let me know if you have any additional feedback after a more
detailed explanation our application.

Thank you.

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
