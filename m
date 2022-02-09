Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3D4AF3B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiBIOIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiBIOIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:08:53 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2127.outbound.protection.outlook.com [40.107.20.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E65C0613C9;
        Wed,  9 Feb 2022 06:08:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUVk1HS6Z2mK7TH0rB77NHrxhoZ8UtxiMgUwhOf5hynmniO0Uq685wclwK6+pRpPZp+2+9Zvf7+MDER5M7PaEYK+QyidFmZdS7+Kdf4O/mqtiDW1kqP15fBH9n8QZHtRuGOLDiUnkfZ4LkSrP+qz97M2lHgdpQPGtUwx+zu0yxnT26GdMSbEWiQ9tqyX1Vjyuc297lNK2nMbut5zFN0rKSzkoyJekIhZkQ+oed6hKbTU2vNtCkXJS1+erLp4UBRMuz5G/iNtPby9DyO1Oqed6YYoJ2P4X1zfzVIQuSA8JyC2iLV9KPM18Vn6bemjBrnQvKd/mef0b/iI3JWx+XEotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0pHPsg7Vf3Rf75nn1/aiyO+W+FUkr0UwVypXemmctE=;
 b=dFguZoR88FPWMo1tvhSOSEWHjT7N4/s4o7Rcoi0z30a1kLMlXVLVOPTrdQhAMO13nGMf6cRbwA6GbHJXXijGXCIGBI2WCrJg8WCDfxM96yE9KNVWcqQLtb+a6n0mJ9uLr00ugg/TqO7tn4IQ6khEL9SifHcDOSqYPJErd2A66tgicS6354sOXapyoX6a9IQoUM5bPpOc/p4QbPKE5X1TIfq20Fe5QfTPGiWihYZBpd9bOqrkP2iOD3IlomuCM5rGpOYDtpC1QCORzrEVfmSUUuZZEDAmytIVTQ30bilKE1VdjtrzNxck6CtNhNcVp9V88TSdRJx09g4mJTIYqu3lMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugent.be; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0pHPsg7Vf3Rf75nn1/aiyO+W+FUkr0UwVypXemmctE=;
 b=YaIRQLEnAPPloi7WNQfavi6ImjE5VUo8JaiQXNbizJqZxyHdnY6iWvLaRfZG8ofiTAS8nGzKKJW1uxm1wGy/Oys6i8yf6DWo6Vo2HdboEJkE1ug9FllcwES/IEAKvICUttQq/L/uf0nVcHPRVw5ZL6Jg4muVSlDhy+aEqZehEn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ugent.be;
Received: from AM0PR09MB2324.eurprd09.prod.outlook.com (2603:10a6:208:d9::26)
 by VI1PR0902MB2176.eurprd09.prod.outlook.com (2603:10a6:802:11::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 14:08:53 +0000
Received: from AM0PR09MB2324.eurprd09.prod.outlook.com
 ([fe80::b115:2e4e:1623:f624]) by AM0PR09MB2324.eurprd09.prod.outlook.com
 ([fe80::b115:2e4e:1623:f624%3]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 14:08:53 +0000
Message-ID: <436acf8a-ea5f-a308-0e3e-fc7c6ffde7aa@ugent.be>
Date:   Wed, 9 Feb 2022 15:08:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From:   Niels Dossche <niels.dossche@ugent.be>
Subject: [PATCH] Bluetooth: hci_event: Add missing locking on hdev in
 hci_le_ext_adv_term_evt
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0285.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::33) To AM0PR09MB2324.eurprd09.prod.outlook.com
 (2603:10a6:208:d9::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1de74638-90f2-4a62-90f7-08d9ebd5b436
X-MS-TrafficTypeDiagnostic: VI1PR0902MB2176:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0902MB2176D21E7DDF149B01887D61882E9@VI1PR0902MB2176.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDMHy7G+xa6MtOEHch2Da0OwbpyJ30FDtnTSSE8oQEIUIixZg9MsyfTmpJ6daCYSLDXyuUfIK1PcB18O02EmoXSz81XKEI/KwECYQ2AKoGhYDgE8nptDSmncPkJkhpZE7obKnlw8PEaapVYvdyEwzRD5B8ROsbVSbCcT2D49Tn0yQ3r0VjBkcr0bD9MebknYnfy+nKD9mK1DT6UY8RjB32p1Ill2GSC86gLMDJH2mehLM8muVu1w17A4+ayVvQrAWnoGdZYX+NvA65hKod89eArAmWkji9g4jDVTGUNKZ9yD3pE9I9IvCVntzB5U2IrcCVzEL4l3V9/UHtQjS8fszsAUNbqvQ5Fhnf4WDCmUNZ0XGVGEwWi1H+sHgHaKWqr2OuD3zMstJJeqyfUYF637fDBozSQOemTumuJw5wvPGiGJvOk5NFVRXcPTF3txKfHhtiF7oJQuvgE40CwCF3ywrV7jI6l554GUmiL/Ge409GEJobmCo+V5KreUXk9hAei6bKKjawSrEJ1FauV6Ho437xwWrotjo+zYOWKo4oPc1DNfFkbvrh9qZaQ+EBAq4OFDHc7k1M/le2O8Ez7D95S6gg13ZtXgKW4FflUyaQdrFuwBUks8cZahCyFLTq5k60C+f8jTUnYNV82A4bNKdRAedxWmJp2IMW/9duttCyzyIR/1cLvH5VBlsAq8M2IcwKYd2cn4Zzb8wzwjki6042BUaVd+D/IDSWjgW3j18CX2MGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR09MB2324.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(4326008)(26005)(786003)(66476007)(508600001)(36756003)(31686004)(5660300002)(2616005)(8676002)(38100700002)(8936002)(66556008)(86362001)(83380400001)(316002)(6512007)(6506007)(31696002)(2906002)(44832011)(66946007)(110136005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0Q3V3hnckY0aXFWRU9BU3Z0ZmJwYzY0TkxKZmVaaWhHYkJESkZkSnJTQjVo?=
 =?utf-8?B?TDNQUFBieTZ1b0hNZTVaanlDdXBPdldWQzgxTk43ZUJvVFp0VzJzK2FlSUgr?=
 =?utf-8?B?REV0Vm1yZ0dVT1hRc2pTVkViZ1lTUTNydDk5OFZIUjBuTGc1bDgxVmx4Z2l1?=
 =?utf-8?B?QjB6cDY0OVpKTUNtbHBtZGtHejMxVy9WaVVYcG1oaWRja3BMbUx6VUhOaElG?=
 =?utf-8?B?UzA4SFprT1dLUXRFeXh1Y3h1MmlsenpBSEVGYXFQVmhXNVJLQkhIZkx4UzVR?=
 =?utf-8?B?NzZ5NE9Eb0RqQ0thTHJpNHIwQ1dSMzh0UFdHOWR1RGkzcUtseXQzTmVaZ2F4?=
 =?utf-8?B?SjZjcmhuMVVzM1JNVTJlWG5SSnl3US9mVkZGclpaLzV5bE91alR1NFlpdVUz?=
 =?utf-8?B?dWRwM0IwWGZHa1I1MzhzdWphRDNYWHRXc1JBaDBpUG5BTVQwaG9zenNNbTkz?=
 =?utf-8?B?ZFQrMnAzNkhMalcwQXNCOUNkekwrLy8vNXFnWjV1Um9DN3djM3pqa1JOc011?=
 =?utf-8?B?dXVnQ0FUeVpYY0dwMDBjTE9BcGk0T2t5Z0FocTBOb2tEczhoS202QlRBaDNW?=
 =?utf-8?B?d3U5N1BXQko4OEZzQnhTdWRkSmNid0tvN3JzSEhZUHFmOTZZcVA0ZDdlS3c1?=
 =?utf-8?B?dHlXYzVBd0JMelFWTDJ5V1F0aW80ZmV2NkNoQXV0UzVRSUtnZFB3RTNTVGRU?=
 =?utf-8?B?dGJNQkU4Znk4RmJyeHFQRjRNdzV1SWxmbkRkUGxiSW5EMVArQVh0NS93WWhX?=
 =?utf-8?B?Wjh6eHRUYUVTWE1zd0lkdnZ3R0tIMjJtdDJKbC9EL3QwSnRONWhWUUdUR0xZ?=
 =?utf-8?B?UVBMemhETWd1cVlGbTFjV1h5VlNYdTlWZ2k3TS8wYUNVaHpVdWszc0RyMlAx?=
 =?utf-8?B?ZlBwYmVBQXIydjFSdk9IaHBDMmZ4dXR5VU9WMzg0Mm9Fa1gwNXRhdzlpOXpz?=
 =?utf-8?B?bDVHVDV3ZCs5WGZXYk8zM1RQOS9MT1AvNDQ3cUUrTVVaVEViNGxxU0lRSkpF?=
 =?utf-8?B?cHQwSnNXQTE5SmhCY0s2NWxvR0xSVWJhZ0l2elMzZDVhVHNsK3NTKzIvbm1M?=
 =?utf-8?B?SUdVdUZtRDVySVk3NFkzZDdCaUNHZ2tuYy9hTUVDT3g5TS9rRjZtVUh6dWJO?=
 =?utf-8?B?Zm0yL3ZIakJYMTh2Q2dIVmM4RUNabnNRaXdTRFBGUEorMWFFUjMzMlVvN2tR?=
 =?utf-8?B?ajZkSjJBdExOK3EwUnVMVDZhL3QzVkw3TmQ2cWo5bCt1Z0wzTkhpSWxoN1NY?=
 =?utf-8?B?a2FVTXJBaHo0bC9MSzZKemlmTkhYd3BPdWZ6dWwvSWp2cndINUszK3ltZXlm?=
 =?utf-8?B?T0ozZ1pGcjFzdHFoVitONkdTM2EreWxjdThLbTJhcHpxQ0ZCSVB0WHVLT2Jo?=
 =?utf-8?B?YXY5SjdsWDNiWSs0emJZUHhHWjcyT1BHRWdCTE1GSE5DSkFiYVgvdExaNXJw?=
 =?utf-8?B?SDlSK0p6WEpuMjZCa0graHVHU3U3TVVXT3NiMjNLTXlCd3J6T1BpaXVoZHNN?=
 =?utf-8?B?M2YvY09aRUh6QnllWHhJQ200MCs1MnBMQWNtZFlHdVFIY0VwRHRvWW5CSURC?=
 =?utf-8?B?VVFnYkp3M2M1YzVIN21SZ1hWS3ZLMEJOZUh0ZVBZSWtJckp0RGFyTVJacXZ4?=
 =?utf-8?B?TEVwS2laVC90QXFCUjY0R1UySVU1SURCay9WWGJhMjhUeGdXOEFXYncyU2ZM?=
 =?utf-8?B?SmNJNTVNaHc0MldxZEE3bnVHcEdQTVRNM1plWlVMMTdsaktTWDVEekxLczdQ?=
 =?utf-8?B?emV0dkQwaU93K2ZCTEQzbHoycEJReHE4bnN5cnNiRTdsNDBSSm54RU53K0hF?=
 =?utf-8?B?ZklMeXhkTUViK2MxR1FQMnJmcmdKM2NFZ3FtUmV6aWVXRGp4V1U0NTh0WXE0?=
 =?utf-8?B?UjdWY0lEZVRjbm05cjhJU2pjZGxucmdvd1duczFIT2ZXMmNUTnVCYzc3cDhJ?=
 =?utf-8?B?a3pWNGh3bHp4LzdGL3ROUDVZcm9vVUVUZ2I3SnJLYXNXTUdkNkVmaDNWQWIv?=
 =?utf-8?B?ZUVHclRqNDg2dG9td09JMDB2NXJ0OCt0Q3QySUlLQkMrMHpKNGtybnNCNzNm?=
 =?utf-8?B?OHhBcWhGY3VubzlGeDlIQUpUZStFWFJqZWcxWGEyZ015bDI5Y3lIZnlabEl1?=
 =?utf-8?B?TGVyRTdNNFNSVjBSejZaZHcramE0NGRYS2Q4ODRveVo5dXh1NnFhU1VIUU90?=
 =?utf-8?Q?ZY73ptExTpKBq5rFc7geO2I=3D?=
X-OriginatorOrg: ugent.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de74638-90f2-4a62-90f7-08d9ebd5b436
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2324.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 14:08:53.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d7811cde-ecef-496c-8f91-a1786241b99c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Drslak3EZr0lfAX9hCq+pUKLsZ6D18+C9EwZYxAxaKlaMDHCgyzuMpbwy8bc5+4E4agVVX2vj0gilJl0QOGJ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0902MB2176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both hci_find_adv_instance and hci_remove_adv_instance have a comment
above their function definition saying that these two functions require
the caller to hold the hdev->lock lock. However, hci_le_ext_adv_term_evt
does not acquire that lock and neither does its caller hci_le_meta_evt
(hci_le_meta_evt calls hci_le_ext_adv_term_evt via an indirect function
call because of the lookup in hci_le_ev_table).

The other event handlers all acquire and release the hdev->lock and they
follow the rule that hci_find_adv_instance and hci_remove_adv_instance
must be called while holding the hdev->lock lock.

The solution is to make sure hci_le_ext_adv_term_evt also acquires and
releases the hdev->lock lock. The check on ev->status which logs a
warning and does an early return is not covered by the lock because
other functions also access ev->status without holding the lock.

Signed-off-by: Niels Dossche <niels.dossche@ugent.be>
---
 net/bluetooth/hci_event.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fc30f4c03d29..3bf048d0df37 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5670,8 +5670,6 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
-	adv = hci_find_adv_instance(hdev, ev->handle);
-
 	/* The Bluetooth Core 5.3 specification clearly states that this event
 	 * shall not be sent when the Host disables the advertising set. So in
 	 * case of HCI_ERROR_CANCELLED_BY_HOST, just ignore the event.
@@ -5684,9 +5682,13 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
 		return;
 	}
 
+	hci_dev_lock(hdev);
+
+	adv = hci_find_adv_instance(hdev, ev->handle);
+
 	if (ev->status) {
 		if (!adv)
-			return;
+			goto unlock;
 
 		/* Remove advertising as it has been terminated */
 		hci_remove_adv_instance(hdev, ev->handle);
@@ -5694,12 +5696,12 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
 
 		list_for_each_entry_safe(adv, n, &hdev->adv_instances, list) {
 			if (adv->enabled)
-				return;
+				goto unlock;
 		}
 
 		/* We are no longer advertising, clear HCI_LE_ADV */
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);
-		return;
+		goto unlock;
 	}
 
 	if (adv)
@@ -5714,16 +5716,19 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
 
 		if (hdev->adv_addr_type != ADDR_LE_DEV_RANDOM ||
 		    bacmp(&conn->resp_addr, BDADDR_ANY))
-			return;
+			goto unlock;
 
 		if (!ev->handle) {
 			bacpy(&conn->resp_addr, &hdev->random_addr);
-			return;
+			goto unlock;
 		}
 
 		if (adv)
 			bacpy(&conn->resp_addr, &adv->random_addr);
 	}
+
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static void hci_le_conn_update_complete_evt(struct hci_dev *hdev, void *data,
-- 
2.35.1
