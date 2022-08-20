Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7190559AE6B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 15:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347320AbiHTNMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 09:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346920AbiHTNMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 09:12:03 -0400
X-Greylist: delayed 509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 20 Aug 2022 06:12:01 PDT
Received: from st43p00im-ztbu10073601.me.com (st43p00im-ztbu10073601.me.com [17.58.63.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4778C47A
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1661000610;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=gPDPYZRYsPkQEjYBIv6re2uprVKRUlm0alDQDjd+s3kxjVEqrP+xK4ebQV6DQjQ+U
         +rrhNHvWDFoVtncMtfiYNWnVT6uHjaUvfcZvMNL0uSulJjpD81S/8vdNHY+1HIb2gX
         UIKjJbWMNG3DyI8fHImyWGwtcYNUajU598tMbv3Qk29TTb6QHgGGPxGNWkq3QaW/8a
         J5pPpQvbHoPDamqBMx2SVf+AHyNfbAw99LV6Q7LtBRh4UyI929IMEEaU+BBA9XR1pj
         xl+OcBSSJILEqohP9ctElfEIcDg0Xg3Wlur83Gd3a438BQwTqRUSuPfsTvUByANG9G
         HimYxaFIaLjAg==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id B9A65180519;
        Sat, 20 Aug 2022 13:03:29 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Adrian Ignac <ignacekadi123@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 20 Aug 2022 14:03:19 +0100
Subject: Re: [PATCH v8 2/5] mfd: qcom-spmi-pmic: add support for PMP8074
Message-Id: <8BE27709-378F-4C79-9CF6-EB3500F15D79@icloud.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, jic23@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, lee.jones@linaro.org, lee@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, sboyd@kernel.org
To:     robimarko@gmail.com
X-Mailer: iPhone Mail (20A5339d)
X-Proofpoint-GUID: Efyf2fbJZLWHNHabz6nDOqlVLMfpjz6w
X-Proofpoint-ORIG-GUID: Efyf2fbJZLWHNHabz6nDOqlVLMfpjz6w
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 mlxlogscore=539 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208200055
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Sent from my iPhone
