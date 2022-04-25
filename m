Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BF250EAAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245581AbiDYUiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiDYUit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:38:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60124.outbound.protection.outlook.com [40.107.6.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF9D1D0DA;
        Mon, 25 Apr 2022 13:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmUsm2v16s2Z9R4fLfWbQTOOb/FqORbQHXrf1gGmT65rj2mXNC/c6WMYgDOOBJDSttEdJIhcrgP84yM3VorQ10VoQHX256I8w9VDei8ffC2s2tpvtXUeQbndu2Upiy2EpoAtHNP0ArIOVQ8b4p4o3oq+YvQeXKme8YuNuBQZ+gDgwS+ah9aABY+SdsXpUC/GfSquvdthTGNVN/Te0uRaCQpr3Mu69QxzeMgZBOlEGseT8L/zhe1Y3sX4h1qQr2gcsPZ6slVmXqOB3mBInt3xWkAiUFl/N7wyWTcbHh2khq2GabR1irL5gINcFBVSXXthguDJ7fj6Gnl+WMP2qOdRJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4OjBO/n4oz9tlR0oXAj8g6Cj/mcU81qdoRgKdinIG4=;
 b=Uw/6UZoe1HFHrj93SHz/TdurLnlDhrQJZAqvbovc7RxObPbZWgFQXy/0hUqOz38x/qqZLT4kAY78Sy467rSzn/hjw+i1M14j6aN+Gnc5cuycZXnNm6FKXUxQM3KzxSphWnh5Trxh0A8XMgATzie8+AR02muKD6JHsg34L8EXjvKCL0hwWJPjHwzKNn1I7Td1lSYbTGSk0a5ZzGpPt04wJr6us6oSzgX1e+nA5HRSKQY04UAtJb3rsHW/1QrVqpwwappAkRcKMtGTrvHw/usbi0irFHuhpknsluz61d3MNlF0hq9115AfZ82Yb4QA8qJs02SxJ4RuLnOiKQOybt5PcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4OjBO/n4oz9tlR0oXAj8g6Cj/mcU81qdoRgKdinIG4=;
 b=XHA0aa3DSqpyV7y548v9n/ggCkj5yuTTNkkeGZqVSbMPCyfMaE9JsBOpWtaEO+00dOpcmhvNyo8tKwN9wSmTUZwrXXf5Dtkuxu5vPExM5rVkSfFeOKJiIi37J3RKTeXzWW+VIQ1IUKkIR3JDRUMupWxZeBir5gSq221sNEGDdPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM9PR02MB6929.eurprd02.prod.outlook.com (2603:10a6:20b:263::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 20:35:42 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 20:35:42 +0000
Message-ID: <9c01b1b5-871a-2b34-9f98-766d043e0759@axentia.se>
Date:   Mon, 25 Apr 2022 22:35:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: sv
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 1/2] dt-bindings: hwmon: Add Atmel AT30TS74
In-Reply-To: <ea4cd16b-4a04-8857-d08a-53be58b00d28@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0048.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::36) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9226697-3fe1-40f8-5a87-08da26fb2ad7
X-MS-TrafficTypeDiagnostic: AM9PR02MB6929:EE_
X-Microsoft-Antispam-PRVS: <AM9PR02MB69293F20E94386F7C3DA6DC9BCF89@AM9PR02MB6929.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SX7GxqYa7GKmSqb7bXVkEe+18ISVNmM5d0usgRNt1IcB4mYBe4tXtnBqiLDqh+30ZKhCoJfa5jwcECDMMnvhDbnKjQQk6+WTqrm0oIUWuZMX/rVDT8DFa05QAsMkwOVXFolZf5WEmOomqAmIE4ZP51cTImXQe/rAkhVLx1LRR9609lElixwG1B8Y3aLbVIp/m+GMc74ha5C35EsDBO+ZtJGM+QgOpqK6w8c6/ho1pOjLHcSpH55D/7k+Nof968/Mb9HIyeSIveoepfmWG0swsv9TYy5pmLL8cMwW1KiS79XhHm5+GA5jVVvRtoeKjkRWISY1pU4xzcli0gFjkmTzyF2q+/2MHBu6Bka1dZ9J+2gXaZ7oaG8EW/GimaErZvNDr3bYXemPpkaC0ynrsLH1i6jAzk2tmoWm0JWWQIUTPLRpaOv5Ni2cTPYr2stiTJxnaweSNNV4s7VRktnv1j/tKKpUFOp+7EH+O4gKevHCzfdCaHklq672/p9eHu9Z9OJAUWNbA4mdvq55KDRabEH5J7MEhdxpXjaAShlt3B8m9YLWklJiQaNvArk6ohzYxXgKoKKKBd4+Zd3LH5/TY52VTvoUP3+MgyQ6woZcLSyJxcopdaxBM2h+4g8WYwssX8NW81hByVxOASMsZn69FCDxsafEng/X+qjIoNkpl+vEzTQnKmzAITV47v0Ood8yMHsbXSU2jj5V324KTufSl5XGoVJ6DvU1vDgADONZH5IzC6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(396003)(376002)(136003)(346002)(39840400004)(26005)(6512007)(6486002)(66556008)(508600001)(6506007)(2906002)(4744005)(5660300002)(36756003)(8936002)(31686004)(38100700002)(2616005)(8676002)(4326008)(66946007)(66476007)(186003)(54906003)(6916009)(86362001)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmdWRE1NSzk4RDJwbHdjcXE1TEk3eEdnaVcrZkZISDd3NjB4V21RTDZiTFRC?=
 =?utf-8?B?TGJaWjlHVzc0TXZFTzFTMytUNllnRHB4YmxxenBCaEtkNmpFQmRhTSsrVHpl?=
 =?utf-8?B?cmlnOW9jN2dhT1gzZHlaMHRHanJKekZqbDgzN284M0hTSnNEci9uVFFhNzhH?=
 =?utf-8?B?cmJRTG9QdVc4Z1NlVnpjUWtFU2FWTElRRXF1bXdUcTVHUVFqd09UTm9jRWp3?=
 =?utf-8?B?dmMrWHpDUnlScXBDT2Zmblo3UHVtelFuYXVqZkJRSmpLY0MyZDBhZHFRVCt5?=
 =?utf-8?B?RFlPbDRzT2VoUjI0MEFva08xeXphWkRPNG8zT0hNTGhybDFWSDJ1aDlYZERG?=
 =?utf-8?B?TzU5U3RLUkFaaURramlZMGlKZFlMcXVSUXppSWJlOTZpTjVkUDFBQmxsM20r?=
 =?utf-8?B?MU11RmpaaGZKYnNDUmRidDdXV2IwSG5GZWdqWm1Nb1VSV2dxV0UzNUJLbFNh?=
 =?utf-8?B?STM2WUJxUXRqWGNzWGpTQlVQZXJDTk1OOUd2SDR5L3NLRitmQTBKbFQxSTN3?=
 =?utf-8?B?L0FJSDFER09xcGV5SW9RNS9YWFEyOG1wTlVxSm9TTzg2UUY0Zkc5K1V2WVQy?=
 =?utf-8?B?S2s5anIzRnZuc3U3Z3VoQTJ5WmxPSVNwZFV0ODUrZGVRaUcyZFNHSFp3Y1Jv?=
 =?utf-8?B?REkwalkxYUl0OEs3MUc2alNrVHJOcDdtK3lFUkgvOGl6Y2ZjZHpVYU10YmtG?=
 =?utf-8?B?blJOY1dQeVdvQnRPQ3pxcjBPN0s4UnFUWHN1UWRiSWoybXJUZG9JdzhjU3Br?=
 =?utf-8?B?c2FyYUpMeWpZWWFOeHlGZWJ2VmYyeU41NmlmMGFZTTZydXFPL1VBU1hvbGpo?=
 =?utf-8?B?TlpUZ2JRZE43ZmxsS3MvR29vMkNQaUQ3RlZNY2l4azBUTmg5R2xZWjRPR1Iz?=
 =?utf-8?B?UHY1VUY1Tm1MZFFGOFpZaWJLN0txZzlIeXg5SDByclkrVVRYcFJHajNVOGVJ?=
 =?utf-8?B?RmViZHpTS3oyU3FyN1l3Z2NZZkEzdFk3anpXZVRDRFlSVGFqL1RocHdrVmVL?=
 =?utf-8?B?bldyenlpM3FCOGl6UVpRUGNpVGEvV3FpRXA3VTRPakJGM0RXeEN4SHRHOUdn?=
 =?utf-8?B?N0hHVWE5RVVnaDRXZjh2T0ZRaEphd1EvUGJBYkYrWGFQQWNYSmRCTkVNTFpw?=
 =?utf-8?B?eHEweGllZm1iM0dMb05qS1lrdWMxekdEUmk5c1dhOFRBNDZlSmsrTnJNYXp2?=
 =?utf-8?B?MzVRNGZnZTJTWEw0T1MybXY4NWdNdFRnSXdmamJoZ2t4ZDVpYVRtcGJaR0kx?=
 =?utf-8?B?c1VwNTBIbW5zMEFxY1NCUGhTRmNKbE9zakxlQlFYVUM2em90eHB5UEt3aXY1?=
 =?utf-8?B?Vlo1TDEyZFNPWVQ3ZkcrOENkWERCUndoeVhOQ09YclZ0SVJ0ZHpiVDRaUHlp?=
 =?utf-8?B?RDlydlh1eHhjcFpnb28wWmRlalVvTkhVdGJoUG9vV1RpYUJ3dzJiblQ2NWJa?=
 =?utf-8?B?V1FZdXZlL0hrb3JJeGtETjlVaHhpaTZuZS80OFBtZlRyVVU1dU85bk1RT3dX?=
 =?utf-8?B?MS9yUVI3MFdXQnIvRTVHUU5jcGRnL0hCTHhVZjhEckVCUE9EYXZSSytaNDlN?=
 =?utf-8?B?TlEyUGU0em1FNXhLSUM2bGpZcXo3N0RiVzB6aGkrZjBFYzJ5NWd4aW5zNDBF?=
 =?utf-8?B?ZlprQ3J3ZGQyMytlK1VIVWRGWWR1NG9paTJvcUo2NXFOTWRlUER5S2t1d0du?=
 =?utf-8?B?djlBeGhlMnNIcG1PRldrT2o4dGN3Yi81QUpqQ1R4VFBqLzNna3owR2VPci9T?=
 =?utf-8?B?RnZZRndCbmFoc0JobERyaldvS2pUWlRrVmJNa25sMzRoSUxseWloZ1RBZWhs?=
 =?utf-8?B?eWVrY2NRSVJxSnF1N1dmOHNtRm9rL0M4SjlQNndvd0ZXTklxakdBQUpRZWJl?=
 =?utf-8?B?ODNIQThJcDFUOWxYdTM1T3R6b1lQN3Y0M0JYREpPNERZVmtSV2ducExUL05n?=
 =?utf-8?B?Ull1KzJFK2dqUER3WElDaFdoKzI3WHhvZEFndWlkT3o3cHpJTHo2WmwxQStY?=
 =?utf-8?B?MW9KeDROWDlETXZyaFJMYmFuQ0QyendoV1h4QktHVUx0UzNxeko3aUk4SW9j?=
 =?utf-8?B?OUVLcWpmWHYrUGRZbXlzek92dTZ6NEdwNkVDcHdXL3NKU3NmSGhhd1pJLytB?=
 =?utf-8?B?M05XS0JhWnJpU3NhS2p0dlZKSG95V1Z1S1Uwa1BGcDBWQ3BVNEZPRnV5bUpZ?=
 =?utf-8?B?U0ZCZ2UyeHk5WlR1VDRCMkZhZCtlTXBVeitzM09QVlJxcDFUcXdXZGJyUDgx?=
 =?utf-8?B?TTRLc29pZnkydWs3cHJkME9Xd3dUWnVhVzNKSnl0OEtKbCtiWEI4czQ0czhU?=
 =?utf-8?B?UGhBV0FTZ01GYVphWkZGVVJhUE9FNXNLVGdQb3J1Wi9GWlczOWU0UT09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: d9226697-3fe1-40f8-5a87-08da26fb2ad7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 20:35:42.6874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1iBlU81wNPZ8Nk78Gip5TRTtLJeGP+5BTDPVLR/kzrNYNcEoiaAsE/AYpM0LxI+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Atmel (now Microchip) AT30TS74 which is an LM75 based
temperature sensor.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
index 72980d083c21..8226e3b5d028 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     enum:
       - adi,adt75
+      - atmel,at30ts74
       - dallas,ds1775
       - dallas,ds75
       - dallas,ds7505
-- 
2.20.1

