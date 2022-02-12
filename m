Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44F54B3889
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 00:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiBLXOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 18:14:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiBLXOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 18:14:39 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70094.outbound.protection.outlook.com [40.107.7.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FF95F8CF;
        Sat, 12 Feb 2022 15:14:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDFOIjR2O7DEYj3qzOdhF6mYeuHrCKWxKkFU0h4UWgDEK1WTVbHNlJW8km3b7O2NyHcNIH2cS5Uy+B82T7gQBfozEDZMlSEnikJGad0ivfwZp4Xx8u1YrP07dhUzzY6ZkzXMJmQxZQkFvX9jBOiQWc/Ig9GZXZd1y6THCHeC5s9GhZ/TP7DHRD4x/zSQZMHDE3esSv8Ie7KzwJg7vFbsxO8oKGydodnb9u25ZCjR/9p231jIfK05263M6KvZV5cw2WOk26phJzDjpKwm9GP3eLPUhIALYTT3O65dUCap/Dw+ad1NnkGvBhtJyXrOtflRwQ/CZGMu9wAUTiLh96NKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRi1MF4CZjlLaJIVvAuNydkH/V+l9HuJ6juhL0I8kQE=;
 b=Q/0mje9ldCF1VtW+DSiuEvQAe0y8elgbFedlDKPTS2XnUeKz1Zpp9SxX4dVpjbqaKUbnax2Cw3EExwiQZNXkGOna1Tfr6ToDHvKEp9vKDEW4w4Genb1E0Bgq4jPehsFgByBfQ5vILz8eaZiAaoYC3nHCWxgT/rpkQHeeQBa2883Uk+9WqKnPomV9q+LBrEwhzWgM+K9gfv6mR2mKs2W6ZILvgtmHpoEwu4x2+B/1+Il1nztvxsaF+hJsm0xdmMxQ5Es8s1BlIKw0i8Erf+jPViVvmzDLSMhW3zCZFbH8Bmtmb39U+6k5IQqB8+TMe/t2WaxjMQFIk0X8f6wK3NFIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugent.be; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRi1MF4CZjlLaJIVvAuNydkH/V+l9HuJ6juhL0I8kQE=;
 b=CZxPJfOeGPVZJS4GCRz0HT+hmBX5chaJcAV07PHZ9mU/nt9UoRdGNxANT4PHpZo4wp14kyKY3jkaBFRb6WXRNFvifW4wJJw5Gix7/DscjriZNNacnZ97nFUPSG1vpx9RaIvZxa+rTI+H0hIzn4dDyZHo9PvTJeWHSlwcMIHiAYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ugent.be;
Received: from AM0PR09MB2324.eurprd09.prod.outlook.com (2603:10a6:208:d9::26)
 by VI1PR0901MB1440.eurprd09.prod.outlook.com (2603:10a6:800:8d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sat, 12 Feb
 2022 23:14:31 +0000
Received: from AM0PR09MB2324.eurprd09.prod.outlook.com
 ([fe80::b115:2e4e:1623:f624]) by AM0PR09MB2324.eurprd09.prod.outlook.com
 ([fe80::b115:2e4e:1623:f624%3]) with mapi id 15.20.4975.014; Sat, 12 Feb 2022
 23:14:31 +0000
Message-ID: <f181dc17-3b27-436b-15c1-832feb573d25@ugent.be>
Date:   Sun, 13 Feb 2022 00:14:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Niels Dossche <niels.dossche@ugent.be>
Subject: [PATCH] Bluetooth: move adv_instance_cnt read within the device lock
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0701CA0029.eurprd07.prod.outlook.com
 (2603:10a6:200:42::39) To AM0PR09MB2324.eurprd09.prod.outlook.com
 (2603:10a6:208:d9::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f5471ec-d5a0-4644-f7a0-08d9ee7d6cc5
X-MS-TrafficTypeDiagnostic: VI1PR0901MB1440:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0901MB14401E0BFC8FEF8FF035EE3688319@VI1PR0901MB1440.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aM4FfqXtVJRHte7Fh0+ZOgKNy5w+UvJjN43V39+CuncNOiCfbb5oiw82krWtPVSUCkk4ruNdPTHibvzUByp2fjU/p5IG9BDg9wvnipFawDHdnZOwzfKzcz7zTVR4A7CyUDxYS8FwNLgK8L6imtPmQ8Vw5050w9zK7pmUGhNBepsWc2RiZnBiMNPKljpQMV2wXABc+XFeGV+8PQbbTkOU/aHZotTv3eTr65g/8dMza35ENfmBf2VHUDEHeSqcTQyB+Iy06MwXbsSEA5tplPMkCpMclbfMO6QGnWrll5FY5O8OzkswBwvJmHJVB7KyflcyjXV3YsfBc8/+leeQlXn3iJ8Qeh0TQQBDbgvInHZAXOiiq7xmALuZJzGShiqXkWmqZwGEVuPgVFAYxUU9ktDWYw30DRBzOUo+prvEd4BVOr8MjLNOMPHcDklnrjBY0+nxkxrQB7TQHC82VowNwV7VES6qRtCuIul3rcnYeVqcsbZ8rF9IUiJdDlPbyr650PJNaIe2FOIakrMcd2XLRJtG5Z4S2eXSahBaTcbmIafMgp+ly4mr4/8Dg5s9MamaaO4VRqkaqrk94UQUDH7cyBka9J/x94XlUqtqfWWiLR/L+D5Kd1zSh3Jwft3MHyTl6MGB/Iq764+8NLzJ14dYaCWADa6AuoodniYjacMDuiUCZ0NCNsaL54/ja1au2BQNDyHQzCfoiuhM/ik53dhAgECI0mGk36vh7AhbkXfoyzV/d/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR09MB2324.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66556008)(31696002)(66946007)(6512007)(8936002)(2616005)(66476007)(86362001)(2906002)(83380400001)(508600001)(186003)(8676002)(5660300002)(6506007)(38100700002)(6486002)(786003)(316002)(36756003)(31686004)(44832011)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlLdEswMVhjeVdKUDFXNFB1a0F5UC9walR3Tlp5YWFJNmRna0gzbzZ0SWhu?=
 =?utf-8?B?V3FhRzhiNmxhMFdUM2QwaVVLOCtPbzZvVTZxY2hPY1FLVTRXcmFvbDZpS3lJ?=
 =?utf-8?B?dkpYSFhkUEhCQjRxWVhkemRCSVh1YkRoL3Z3Vm10QVlYanIwYlN4YWxESlRu?=
 =?utf-8?B?VXVmYm5wL05oNkZOQmNtSG10TjRQYnl2cFRrOElOakZRa1ZkL2dNa0IzQWds?=
 =?utf-8?B?MjROeDk5OU5OKzV1WVdoZW5kMGExbjJoVkduWTJGT1AvMjJoUmJoenFPRk4v?=
 =?utf-8?B?UlYyaTlxUjFkTTlwMHgzYit4UGZ1bjlrNGY3ekpYSnVPSFNIYk1jbUt2MHlm?=
 =?utf-8?B?MjhwbW1zTDlQdVpqYlExSVJ3V3QzTkJranZ2TVAyeWdmV2N1QjRmN0JET1Zu?=
 =?utf-8?B?SmdOMUthaFVsQklDRUdibXlZYTVzODNoUGhpVFNiUE1rQmhjWGFGcC9YTWpF?=
 =?utf-8?B?cnFoZ0VPbXdZYzFmZlI0TTJ1emFyWHJsS2ZSZjZ5UVlPR0RWMzIzcEMxMENo?=
 =?utf-8?B?dTNsYzBUQnNtYWdqem5PUnFuR3VjcmgzelRQZE16WVRTbzd2SkxZOUh5VTFo?=
 =?utf-8?B?OU1KSW4vdGgyNDgrQ3J2by9pT3Jjd2tBOXNUcFFtK20raWxPd0tGYnREWVNT?=
 =?utf-8?B?SndQOVdQSU42bGJwdmNsK052b0ErS3Q5VlFtUTRvVEVjYnVHb3ZValBmamx6?=
 =?utf-8?B?KzFLcGpmYm5ZeHZ4RDdWOVEraGtXdExkMERRcEo2S3pZRTFxTG1ZaUtZR0NQ?=
 =?utf-8?B?dmNNZ2I0Nk9udEhGVFJrQklvQkZnbWtnT0lPZG5vSE4zcmV2RzhiZjhQUXV5?=
 =?utf-8?B?TndxZkNLQ2dkNmlCL216aXQ2dVhIUGRsMkt5eGM1cjF2OHMwNEVoZkNqYm5s?=
 =?utf-8?B?eHhYckJDNW85MVhpYnhRSVk1Vmt3VTFYU1ZYSU1vWHBySnFZd3F2cDZ3R3Zj?=
 =?utf-8?B?ZFFSSGY0cExaSnZWTVNzeHd6VU0zUURaejREcUx6RHlRVmcxT241cEZNUDdl?=
 =?utf-8?B?SjJ5eWM4Q0p6QWRNVk1FS3Z3QmdZWDBQZzc3R1FIbnhWOFJtblREenJyTy90?=
 =?utf-8?B?MEJDcngzUkwzWEduVjhwSi85ekswNXRuVmFSMktMRFZ3VzM1elBQQWtoRnA3?=
 =?utf-8?B?dGxRWUZqNG9zVkVBRld2cGxCa0pBUS9yY2E4VkdnaVZrQnI3QmRlYzhMU2RF?=
 =?utf-8?B?ZFBYMGxlNCs0ZklRbG1NYWcveHQ4SFBSdXNld2JzNlB4Yk9vRGF5SG9DZTdm?=
 =?utf-8?B?RDBHVlRIQ0xINEF2RTByeFVHS3NISlFaTW1LUnI3SlBaaG5MeEx3QW5GT1lz?=
 =?utf-8?B?cDlIMmk1bWIva1kxSUJHclZhOCtJVzJSUG0zR09oNC9QeTh1eVRza1hEM1Bq?=
 =?utf-8?B?cmRsaU9IdEYrc0tiREdyOUJWRGRnYzRvaDZ4czcrQWZwNVh2K09raTJsNXdk?=
 =?utf-8?B?VVEzUlZLUVAySUgwTit3QkkvMGptSFFFZmltYlpxbXlMcVdHYlhsQVV6MTZQ?=
 =?utf-8?B?ZTMzZ095d09HajJJSlI2L0MxVWFocDQxa1pIVTBUZVFHbWVBL3BrUGl5VWxF?=
 =?utf-8?B?eC9UVHpKa0RQektEZlBRK0YwZXY0Vm5IWHA0WUhZRkZyU05nMy9WK3luSzFU?=
 =?utf-8?B?NVdYeHBCYmVKUEZpYjlHZVpFZExWMVk4YnQ5RE1FWEtsWityNzVrZURZaW1D?=
 =?utf-8?B?Nm15YTd3S3VmKzJzdWlBR1lraGhmYS9vbGpEV3VBZGZSZks4OHc0OWE5TzlY?=
 =?utf-8?B?aktqQWtZZHJQOWQzN0h1QWlHQndjTkZpQkM4TDRUTHM3cWt6ZElxZEx1WGRP?=
 =?utf-8?B?OWZOaFRnY0UwWDYyLzVCRUJ5NVNLWmdNS0ticE9ZL3ZIODM1S3EwS1RZUVFw?=
 =?utf-8?B?OGJpdm1uMmphRDJIdEo0WWl1Yy9ZRUZZWldhbDI5ZTFRMkFnTGljZ25QbTh4?=
 =?utf-8?B?TnpNdUhic2NId2ZsMjQ5TWp6YW03VzJyOElTNFpkcVJHK0FnZTZpWER1d2Qw?=
 =?utf-8?B?NVo1N1I5eFMwN1YyTGJFbHI5c2swWHZZcmttcE9hTjBXYnl4d2JlQXdHNlpC?=
 =?utf-8?B?VndRczl6R3BJQUY0cnkyZHNlOGx1ckswNVdkWEljb3ZtbW4zSVp4ZHVyZ0JB?=
 =?utf-8?B?N0c4UFB3VXJ4VWFkRGlGZ3NhNmh2QjdCRnhXNk9BRkc4UndCaVgzOFYxZWRC?=
 =?utf-8?B?czFpVERrWW5oMTZvNHdDYnI2ak02eXlubWhmbGs0NFdVOUhkR1RqbWJKY1E4?=
 =?utf-8?Q?QyD8P8Mi9ZJ8IQXs/1TJKkpGqivuah/zlE/KkkszQY=3D?=
X-OriginatorOrg: ugent.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5471ec-d5a0-4644-f7a0-08d9ee7d6cc5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2324.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 23:14:31.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d7811cde-ecef-496c-8f91-a1786241b99c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COGr7kDS1zCLIrVB0+xm6a7tQyxixCgBp+RcIuyACHslLgLizMOAmRYkTz5aDJI+gzD8+obxNYsoBHDqOzoiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0901MB1440
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field adv_instance_cnt is always accessed within a device lock,
except in the function add_advertising. A concurrent remove of an
advertisement with adding another one could result in the if check
"if a new instance was actually added" to not trigger, resulting
in not triggering the "advertising added event".

Signed-off-by: Niels Dossche <niels.dossche@ugent.be>
---
 net/bluetooth/mgmt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 37087cf7dc5a..e0dc72f147b4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8046,7 +8046,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	u32 flags;
 	u8 status;
 	u16 timeout, duration;
-	unsigned int prev_instance_cnt = hdev->adv_instance_cnt;
+	unsigned int prev_instance_cnt;
 	u8 schedule_instance = 0;
 	struct adv_info *next_instance;
 	int err;
@@ -8097,6 +8097,8 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
+	prev_instance_cnt = hdev->adv_instance_cnt;
+
 	err = hci_add_adv_instance(hdev, cp->instance, flags,
 				   cp->adv_data_len, cp->data,
 				   cp->scan_rsp_len,
-- 
2.34.1
