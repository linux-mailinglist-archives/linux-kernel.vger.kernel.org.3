Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12A9592BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiHOIRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiHOIRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:17:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B9C1EAE9;
        Mon, 15 Aug 2022 01:17:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F4ipES007133;
        Mon, 15 Aug 2022 08:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=qc/Pma/0OS+jymNRcR/JdbSmnW4EvQStKXLinLlbqn8=;
 b=2zbegTxb1CGVrwKaXFvBGhQR92aMIOjC/EMVQvS1p3PQ0kwyi7aPQK10bIe7s4H3HdxC
 FO3lay598M/AoxiKgwxflEJDeI6Ya8+XreNgkWd6sCUg/axaIbgJqUJwufy4iGo24rv9
 qDSjhvLIw7oxjRM89K0MpjCSgVUSoF6q+ybEDRA4ssKc78Uq/SRhveVMqLMxwX2zMxGy
 F5xCsQpfPDSeMwESkXAXOLbLhA7y22oBZwTn5x4u7BGX2NE9ChI1rwq7iZiTW25AIdB9
 oupMx2vBomzSY9K4YlR4B+MYj62hE18XjhXIMpfi5mqS8RBO8aeT3xrUcwJ5N2UxNqF6 iQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx3js2e7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 08:16:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27F8G4ZC002102;
        Mon, 15 Aug 2022 08:16:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d17537-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 08:16:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAyX0Jfp4h2hueUn9Fk2a7xWZmDogOS/Yjms9+38zfMIxLiriGSoZHgJLDx8OYoyUNUClls4iWzXW2h44swbAc3n1Hcz7xFaMk3qoOCxQN51b+pciRfDVLhNYkbDx7yUGI5YXpLRE8XvZGxvMIfh8meq8hzwRVQSAvXpl9tKxzzbyTq2Gy7nmjjp3cH+WVHdli7xD1z++xHMJUATHsAQxGrY6HxWWz+5dY8VUYQ3HpqrhWTTm//W96mStw5R4W98tygQnbSecKgv6bceqyH5crT5fYLs4hl/UJTQ//yPMJJohMLPNmQSp8Po+s1K+9n/Qp8Aw6QkwMjqhrRVnkfJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc/Pma/0OS+jymNRcR/JdbSmnW4EvQStKXLinLlbqn8=;
 b=n/uHKx+pC79vXmpn7G4qrZb4XVBS9w65dVIMbe4/Jq/HGheG2UDc74zTgqBzJCPqHGudIc7/9+/kdWrz61fyou6M2sUVO0Bf4sMq++1F/VQ7Ypp/2FqiiEJeuIKeGVnVXdqG3z1zkvAgr1E2LhuELxaXkPDRstfP9dWdG49O22l1Tb8wt+XxTY6kbPAhDL/zDsRcaorY6279pkviePi87Q+GWRBNZawwiCqkqxpQe+cCIf9saV/flxEaPJ87NUttiZUfFzqvca/MXMPCzbASm6xeI4SCa9DE9n8iNFA9YSSy6Z9gk0QUq+XtIRc3D7PzD2FXDvY4UPXkEThaunLsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc/Pma/0OS+jymNRcR/JdbSmnW4EvQStKXLinLlbqn8=;
 b=tgOlKc5YVIMBbv8YqLOaU/ITAzDBgM2jAHZcYVug8sR/rIj6vIIubRoDleKdy4FCg/W1Vp7BS+og0NHM0E/rIWbBK769aKjkBQIcdnL6a85+nh45ilK/rXkppOpm+qoNJiRgPXoRQGaQ0Axf44VLFvoV/iBnHJEJYFuXVn3fZxw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2982.namprd10.prod.outlook.com
 (2603:10b6:a03:8a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 15 Aug
 2022 08:16:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 08:16:20 +0000
Date:   Mon, 15 Aug 2022 11:16:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        margeyang <marge.yang@synaptics.corp-partner.google.com>,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        marge.yang@tw.synaptics.com, derek.chegn@tw.synaptcs.com,
        vincent.huang@tw.synaptics.com,
        Marge Yang <marge.yang@synaptics.corp-partner.google.com>
Subject: Re: [PATCH] Input: HID-rmi - ignore to rmi_hid_read_block after
 system resumes.
Message-ID: <202208142212.QB3fvm5l-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659336403-2546-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0003.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5ebb7df-10c6-4135-4b12-08da7e966f32
X-MS-TrafficTypeDiagnostic: BYAPR10MB2982:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAW7bw9ufWIayMvkR7nEicb09no6YVr9BqVpASrMs2FnO803tPtPSUqkVsuWhQFt14ZWVUWrYohNqG8OW3rEeQzOEO03zT7EbKJ7u7N06U0JCB1AL9BjeD+W9cRMxGJvZ4mvUJqiYjqWaSfSMyT05PTCYf2ih1bsNMixtmQ34IFYaVQBshO3jAR4NUZkxFNlHnb1+J9E7EFStVfvGItypHgRu5WOGLTJhp2UzT39K6eFsr71Pn3rz3gsx9T+QcdwUN/LldcLw+LaK91gYxcR3r5SmsXTLtohi+h+2nrBS1ZiHLNLWxVqdRTFjMpmoJM+t4k2cxF4REP0sqcs20mJhrXmwN326lhRHZ+/aBx82x83oataU66xpDVfdOge54FS0u3sB189PRkuhf82X2flRaV47nhW7gz6err3GJxdGcqA+lX+2UHv0KBPbHjxd9dZvRWkrgynPAQqV/f0FTuaI/G0G9c0u1vjqQMsFhv8xGKrcACOMoLDehkmwoSsQ+elgJ/UyJupshG/eH6w1a3aERKPp0vOeJy5eiLXzchd2fcytNx5bQehVaDbzPD7KYSQlsApRR5CpwtMcXPTprRuSgx742G8AwisPjB9UCzpXERVHeAPHJe+xkgDuGgQBTHTSAxQHAkWY4wwmj4UQ2evD1ePczbaujsEADJaa5hh2LcrQ+JqbgOgp0fcoYWQ6ig6FEe603qHlrenSiDZY38bYHN284t8xK9/Ak+PYTcIzW0GRY51ATPdZ0P9kFPklrDs1yNdxi49LgBl3yV2z1uFLyZKmI5aqD4MaFm4Lp9FVEXySNFHPcDGw3b2SLwS2wVLrOBjSx1nEKlsmO159ej2MSpThPLII3YnA7Oft2Kk5/E0SGEwwIhZGSFllzWWHhsF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(366004)(39860400002)(396003)(83380400001)(6486002)(966005)(26005)(478600001)(186003)(9686003)(41300700001)(52116002)(6512007)(6506007)(6666004)(316002)(1076003)(8676002)(36756003)(66946007)(8936002)(4326008)(66556008)(66476007)(2906002)(7416002)(44832011)(5660300002)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S9wWkYOm1cdx3VrP3W/1uWutckqJD/J6+lVWrOzZ4sMG3ADm2NLo6Brsu7hr?=
 =?us-ascii?Q?89TwDC0bFEN5yqsD/JAmpEFK8juRI4XzOy3sSuAPGvNrXqTCgQTQYa63857R?=
 =?us-ascii?Q?K5nuKQrSs3yNJ2IXFJA6dNPb4zW2sDj64NY+45YT9865zfTcmOxRwYsycVB9?=
 =?us-ascii?Q?NYEyCBGTDdkbO2gvDhuOhpmldCZ9YflbVfdbw6pmDdunQonx6RyzWLdnlTdt?=
 =?us-ascii?Q?zi3hYRW1DlGf43Q9V4gHiWbSiVUYoFJXklZvbL9wwFpENKpUq+uSQAwbfPuz?=
 =?us-ascii?Q?BbcIjzXgP/Cu32zsfYjq/pR/vTgdB/3g5wSB2yZlZE2JJQQXfcLgSXm/LRsD?=
 =?us-ascii?Q?Py9VK8G4pM341YHaFsidwIJAj2khYn2EEWhAxYIO+hOVhbL/4ND/DbwSHFAk?=
 =?us-ascii?Q?8e2S3uy20Wah3g1rbB8oMemrokAjnWlmgZls30tdsrxvsXKIHc2RWbKFam90?=
 =?us-ascii?Q?N4uNfrn/gYA/ntzAsXXlsTIgxS4SjG1fBN2o96t+AsJaMEGzpg1kbS0UjxRy?=
 =?us-ascii?Q?0mL4DSkFqQ1IsheyT8DzbBxlBV6SQB9rrwCFMFXbCs/i+/Fa7Q7DJJLUYKgb?=
 =?us-ascii?Q?NeLpdIJ5OVlLjzePwZc9eUAydU4ogup+hRAXSmV4lbSHjArBaxoX/ObPEaOp?=
 =?us-ascii?Q?0/+e8HbjyKihjZwf0TfzXXaRA0P/Tbz5ue6td3e0qK0C2ddJ2NyUf4u3L5vX?=
 =?us-ascii?Q?1vvLoKFJxijXypv+CpIm818bXWs8Bn6Tk7zAW+Tlz35d7lkKwr1X9rSLd5og?=
 =?us-ascii?Q?ClDXUIo7ttFPSZI8g8M3/yohSSECGq+1QYwymn3RhKM2EnJG+MhTY0QLA4rR?=
 =?us-ascii?Q?GiRxRCcPXV4q9LUt0NsilNZZKUTuYc8OZNpme7qked1yeGCxMYR+rtSU0XoI?=
 =?us-ascii?Q?lmV/ZAGKYWw9z3WmZBjVvRpmifaN+boThPEVgV8xe6xTfbN3xFl1c6pIbx0A?=
 =?us-ascii?Q?yigPLbEMMaZSzLuUWdvYrzb89v749dmiggr+ccxbCbfrRNMpxZx+XFlarIji?=
 =?us-ascii?Q?4vWXBnjUIKmkLjbMncKku15T0NzRdStu2KuroajPBgbn4p3bXcpZMrr6xNjt?=
 =?us-ascii?Q?N6/Z1jBdddVPurQm2PniiEhisMjVlD7/Xnlxk1fxnRTm51wOoczRvlxUZCB7?=
 =?us-ascii?Q?ag+Ka4ZDofZfYcHfZ0g+bxI/IhLGj3pFSGyHJmiQIt9NemQ+myYT+0IQYmvI?=
 =?us-ascii?Q?AUi23nRBw7MYz0YnZmNEJzvk4ta4NTOFhFBJdxOlo3T5n6Ysj/yqaKtSK02t?=
 =?us-ascii?Q?CGDxIpDIQBlevAfuePVYducuoxEKxw1db9AGZDkVByqXcM0y3M5hy9TyKHyU?=
 =?us-ascii?Q?oCcNjpvcaIix8fZSd3bV3Y4w3KlSnWGor9MbWCbcSPxfnS9XKAPk7ZZhKGtp?=
 =?us-ascii?Q?5zWu8M6/ryxRt7HPRDXQWi0os4VXFu3WiSCfV0M3YJ4dDxeSfIW4EASeuMw2?=
 =?us-ascii?Q?5p8UGzQzcJLwqrKKZWO3uAQ53tZujP3jzqSUVvDc/znjWngJKFeC8EVUc9u8?=
 =?us-ascii?Q?hOhuuTALARs2KWYw92Vi53hf0UjIx+LxsTJzHvnPx/1PT6fmiMGwTy+La77m?=
 =?us-ascii?Q?v+c+VD1wxHEdaPjQ2MsS8nfvtojj+T/tfp2qBCMzpjyKQq3VVOcEG9NuX1wp?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OohcrdEcTMG1SednCaZ38mrwj986Uavqy1mWB0CxDcR+9f41KjSkVMRdu6ud?=
 =?us-ascii?Q?OcyyUNbfvz3oPT4t25kNtd6rPXwNYhfNE8/YL6krJWAtW3ZsqfexZlP7BV6/?=
 =?us-ascii?Q?yjepJ0GT08Ybu3hBY9TXayEO8Q4RSxz0hzksk1UHT/DZxSnHUywko1zA+LUf?=
 =?us-ascii?Q?+baxwaHLpBHpauPbJYkSsfv5Dh8N01H4rXJa0Zw0NiiQAyQViHA0RBxcwDwN?=
 =?us-ascii?Q?06fgpuR+/3Jo+mbbASKQlPohrqHBSELgzp51PxTgbTAI6wbskjISfi1POKPB?=
 =?us-ascii?Q?zfJ1H0TcLvWAYB4zgxBvyja2bZNiYDSODlo+ScsRgiLmcow3gPsHDWKZqh7Y?=
 =?us-ascii?Q?mqFHnoiiE3eXroFVsr1CYsiiyX8EbpR6X1yvq0VxAsZfnERuzUUdJYp3f2db?=
 =?us-ascii?Q?WC+gEM0FXSTzpH+7FSswKyuVFqdkGU0iu3vmCqk/pBQirL47pdFJwrDbM9R9?=
 =?us-ascii?Q?ol2dwhcl4wj6UGfMK3Gl3oyVGpIpN5ZVnkuXNa3/BtV0SdqqhMuwmMtwr+NY?=
 =?us-ascii?Q?c/kWZRrxTTfw5gKYylRcm7NeXN81ypcxfSovvURc2oxc1bbB9CNMbqqKVbyx?=
 =?us-ascii?Q?u4w/89gaDsE/EFpK2DIeUWn1A/VprQOnIzjfnxEFdMLdorH0db+gCX2yeFP5?=
 =?us-ascii?Q?g+r1nDUIW6pNP+ZsdF0FCzysGk8q2qGXHd9EpBJSojxPw4WvkJeoTX0/OauJ?=
 =?us-ascii?Q?qPwWwIBWKKsn9duLgylFRG9yk26yIEixeSMeH/eo6wICCRox0aNJD5wdpic3?=
 =?us-ascii?Q?afGCLXBj/qJEgkUR9HLf/zWPxCpGS4DMNDG9LrHGZvXI1h4/5krhkoUrO2Mu?=
 =?us-ascii?Q?gAEXacbqjjRhVKV/7DkqoqVySM6QtGDGQb5TlLNQre68SJCTibQXG4r6bWlF?=
 =?us-ascii?Q?u08MkhA2eYKV/iebpqYmEUW/Pl0IBqI38643698SFvTvVx7HAuGQuIG0hy1p?=
 =?us-ascii?Q?3u/cn6KkBkHOwYgLg2KPuZ6MgufxRlzwlXNlEqOb3Q0x63OlvwmbRVASYznd?=
 =?us-ascii?Q?Inud6tf2AU5vrLIVnIgByfPJpHGuKA6VFU+EC00YhJ7gx3Pg7CCRxZ85FkaN?=
 =?us-ascii?Q?gILXT562aoaSctRMDtJgXHpPDZ3VIChSS1Xfy5qLZGZP1TeC5NoN/SATribo?=
 =?us-ascii?Q?jVYOuxag1MtKu28mPmjyRessguNI2ZnIbgEAeYuQkpQ2CWASqiJrhPFyPBNI?=
 =?us-ascii?Q?aXRPu+UWxP7wsKs+d7vf2yBdo1tKWhdPJjju+hZo6du8lXPRWv20yAg7qX7k?=
 =?us-ascii?Q?8iPG3CLuVPEYM8iyd3MlBHA133s9UkKfqiB9tpmG4hcAuyD1eNqzg6s9LaXz?=
 =?us-ascii?Q?rWsSagdyHxtWnooKLMTZHi1ZzfksFTdStYLrZWA4q3hEG6BONRScNdEMB6JL?=
 =?us-ascii?Q?wFz2zGo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ebb7df-10c6-4135-4b12-08da7e966f32
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 08:16:20.6794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nonhNHm+vQsIUu/bZwkJMHEASZeKs1Xm22ceJnDmFslLAN3nSktTA8DfCKwUIBV2mEILZ2j+sAU6QnR8d+RuKx/qxgSw47OcxUU9Y322raM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150029
X-Proofpoint-GUID: 11bDPSVb211SeIsRSGRqYgJ9HPHbHwDl
X-Proofpoint-ORIG-GUID: 11bDPSVb211SeIsRSGRqYgJ9HPHbHwDl
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi margeyang,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/margeyang/Input-HID-rmi-ignore-to-rmi_hid_read_block-after-system-resumes/20220801-145006
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
config: x86_64-randconfig-m001-20220801 (https://download.01.org/0day-ci/archive/20220814/202208142212.QB3fvm5l-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/hid/hid-rmi.c:263 rmi_hid_read_block() error: uninitialized symbol 'ret'.

vim +/ret +263 drivers/hid/hid-rmi.c

0b2c7a897378f1 Andrew Duggan      2017-01-05  188  static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
0b2c7a897378f1 Andrew Duggan      2017-01-05  189  		void *buf, size_t len)
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  190  {
0b2c7a897378f1 Andrew Duggan      2017-01-05  191  	struct rmi_data *data = container_of(xport, struct rmi_data, xport);
0b2c7a897378f1 Andrew Duggan      2017-01-05  192  	struct hid_device *hdev = data->hdev;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  193  	int ret;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  194  	int bytes_read;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  195  	int bytes_needed;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  196  	int retries;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  197  	int read_input_count;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  198  
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  199  	mutex_lock(&data->page_mutex);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  200  
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  201  	if (RMI_PAGE(addr) != data->page) {
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  202  		ret = rmi_set_page(hdev, RMI_PAGE(addr));
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  203  		if (ret < 0)
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  204  			goto exit;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  205  	}
30a3df7ece6145 Marge Yang         2022-08-01  206  	if (ignoreonce == 1) {
30a3df7ece6145 Marge Yang         2022-08-01  207  		dev_err(&hdev->dev,
30a3df7ece6145 Marge Yang         2022-08-01  208  			"ignoreonce (%d)\n",
30a3df7ece6145 Marge Yang         2022-08-01  209  			ignoreonce);
30a3df7ece6145 Marge Yang         2022-08-01  210  		ignoreonce = 0;

"ret" not initialized here.

30a3df7ece6145 Marge Yang         2022-08-01  211  		goto exit;
30a3df7ece6145 Marge Yang         2022-08-01  212  	}
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  213  	for (retries = 5; retries > 0; retries--) {
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  214  		data->writeReport[0] = RMI_READ_ADDR_REPORT_ID;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  215  		data->writeReport[1] = 0; /* old 1 byte read count */
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  216  		data->writeReport[2] = addr & 0xFF;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  217  		data->writeReport[3] = (addr >> 8) & 0xFF;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  218  		data->writeReport[4] = len  & 0xFF;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  219  		data->writeReport[5] = (len >> 8) & 0xFF;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  220  
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  221  		set_bit(RMI_READ_REQUEST_PENDING, &data->flags);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  222  
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  223  		ret = rmi_write_report(hdev, data->writeReport,
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  224  						data->output_report_size);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  225  		if (ret != data->output_report_size) {
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  226  			dev_err(&hdev->dev,
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  227  				"failed to write request output report (%d)\n",
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  228  				ret);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  229  			goto exit;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  230  		}
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  231  
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  232  		bytes_read = 0;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  233  		bytes_needed = len;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  234  		while (bytes_read < len) {
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  235  			if (!wait_event_timeout(data->wait,
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  236  				test_bit(RMI_READ_DATA_PENDING, &data->flags),
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  237  					msecs_to_jiffies(1000))) {
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  238  				hid_warn(hdev, "%s: timeout elapsed\n",
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  239  					 __func__);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  240  				ret = -EAGAIN;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  241  				break;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  242  			}
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  243  
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  244  			read_input_count = data->readReport[1];
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  245  			memcpy(buf + bytes_read, &data->readReport[2],
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  246  				read_input_count < bytes_needed ?
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  247  					read_input_count : bytes_needed);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  248  
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  249  			bytes_read += read_input_count;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  250  			bytes_needed -= read_input_count;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  251  			clear_bit(RMI_READ_DATA_PENDING, &data->flags);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  252  		}
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  253  
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  254  		if (ret >= 0) {
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  255  			ret = 0;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  256  			break;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  257  		}
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  258  	}
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  259  
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  260  exit:
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  261  	clear_bit(RMI_READ_REQUEST_PENDING, &data->flags);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  262  	mutex_unlock(&data->page_mutex);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07 @263  	return ret;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  264  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

