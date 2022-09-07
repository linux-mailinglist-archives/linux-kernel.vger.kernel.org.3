Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB35B0A9C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiIGQrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiIGQrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:47:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F15ABC832
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:46:52 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2879UX3w029087;
        Wed, 7 Sep 2022 16:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=x8tPmzhqIu86gfIvQKQ1pf+xUKrSbZEnb77ZwGSbY4c=;
 b=jKqTKmqSrtnvhZ2rL5zXecU8rtIRFJIthL87ysblwseddZ2wAZ3Y3E7eQOAvJyfq7a66
 Q26keAWVQeoSeMWPtmcNNXH/gNK1RSo5Xk+52i3fPN0uJshBHcGYwM0Ql+2nfce0Vh8F
 mMJfvaDzQv3xMdNXdPT0BIkMM33qpgJUVEKCIkEURTBwwmTDKaN4PqDLZfFWQG9fqwuH
 fWgmeEPJm8Zhf71elLQMUDTm7I0jpiO00VxT+L4zR0oIgkjSRUXI21jxv1i5JZmZDqCs
 HiucXgTuRcNQjcPRqhH2xfCmtPaVwZPyA8Q08UM37V22AAoAcP5PTbu/0YLVGIi/S2JS hA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jeqfwhx2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 16:46:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 287GU7iJ013198
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 16:30:07 GMT
Received: from [10.110.17.89] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 09:30:06 -0700
Message-ID: <dcace322-83e6-0a3a-e049-810ad50b58a7@quicinc.com>
Date:   Wed, 7 Sep 2022 09:30:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [mani-mhi:mhi-next 2/3]
 drivers/bus/mhi/host/pci_generic.c:734:60: error: assignment of member 'irq'
 in read-only object
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <202209072144.lWoBySRH-lkp@intel.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <202209072144.lWoBySRH-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DR2KLrpRJiI6xQx_aWAk0lUA5DoP16oF
X-Proofpoint-GUID: DR2KLrpRJiI6xQx_aWAk0lUA5DoP16oF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_08,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=773
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070065
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll address this.
