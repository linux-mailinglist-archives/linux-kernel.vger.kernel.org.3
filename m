Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E359D59E522
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242466AbiHWOdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240968AbiHWOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:32:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7862E2B00D1;
        Tue, 23 Aug 2022 04:48:32 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NAg6ZD011060;
        Tue, 23 Aug 2022 11:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QSLYiHAsn23zUE198X1AV0Aoh53UYUwYj8qTH1l6vnc=;
 b=d1r05Dn0U1KJpLJk/dqVHvU6S2QXH4yVC1EAWixGoHlzRq4AviChLAE+GBM3GwTfhcqY
 5ZQievIuK1WNScgU7c7toLaVXO5nKkJzPh4ypY3YK4N6MUZ9hTkSSl9TRKE+kCmrhrQF
 llBGGSZhxVKOXKQcPc/aCHqv7Cv2pTzInHiH9ms40eVx4ClGbJ/Z/cHBhCkXziu7hVAJ
 KfGwhlxVdBLJjZM84H4mL3367x1zSH4RhYp5XFzHNMJyrkWBF7ZIE5WUJIkanRMyCYtB
 W56+3dmh+QA8VNkcoqsrVVE0c2RPocHyD0fE3uEGBOo1CRaLq98eO0HIphhcJ24320XT pw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j4t6xs8yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 11:47:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27NBlVkc032574
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 11:47:31 GMT
Received: from [10.216.14.158] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 23 Aug
 2022 04:47:28 -0700
Message-ID: <4d3edb1f-d8a7-8335-78a7-fdfe7c7a8c20@quicinc.com>
Date:   Tue, 23 Aug 2022 17:17:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [RFC 2/2] soc: qcom_stats: Add dynamic debugfs entries for
 subsystems
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     Caleb Connolly <caleb.connolly@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220818142215.2282365-1-abel.vesa@linaro.org>
 <20220818142215.2282365-2-abel.vesa@linaro.org>
Content-Language: en-US
From:   "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <20220818142215.2282365-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jopR7pa8yf0QCVwdur7wVP-KpQgSMpcr
X-Proofpoint-ORIG-GUID: jopR7pa8yf0QCVwdur7wVP-KpQgSMpcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_04,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230047
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the patch.
> +static void qcom_register_subsystem_notifiers(struct qcom_stats_priv *stats)
> +{
> +	struct device *dev = &stats->dev;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
> +		const struct subsystem_data *subsystem = &subsystems[i];
> +		struct subsystem_priv *ss_priv = &stats->ss_priv[i];
> +
> +		ss_priv->subsystem = subsystem;
> +		ss_priv->root = stats->root;
> +		ss_priv->nb.notifier_call = qcom_stats_subsys_ssr_notify;
> +		ss_priv->notifier = qcom_register_ssr_notifier(subsystem->name, &ss_priv->nb);

The subsystem->name passed should match the subsystem name already 
registered with SSR.

The names in below table don't match as of now. for e.g. modem uses mpss 
name.

static const struct subsystem_data subsystems[] = {
         { "modem", 605, 1 },
         { "wpss", 605, 13 },
         { "adsp", 606, 2 },
         { "cdsp", 607, 5 },
         { "slpi", 608, 3 },
         { "gpu", 609, 0 },
         { "display", 610, 0 },
         { "adsp_island", 613, 2 },
         { "slpi_island", 613, 3 },
};

struct subsystem_data {
         const char *name;
         u32 smem_item;
         u32 pid;
+      const char *ssr_name;
};

Can you add one more entry in above struct with the 'ssr_name' for 
subsystem.

For the adsp_island stat you can re-use the lpass subsystem notification 
and create/destroy debugfs stats files for both adsp and adsp_island 
stats, similarly for slpi_island stats comes from slpi.

The gpu and display don't have any pil/ssr and hence same notification 
won't work for them, however today both of these are unused, so you may 
want to remove them from above table.

Note that In downstream we have 'apps' stats as well in above for which 
no registration with SSR is required. May be need to leave 'ssr_name' 
uninitialized for apps/gpu/display and skip register for them.

Thanks,
Maulik

