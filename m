Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B15651AE1D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377587AbiEDTps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358531AbiEDTpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:45:45 -0400
X-Greylist: delayed 527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 12:42:08 PDT
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418474D26E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1651692800;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=mpWDTIXkVWICEbwP8lVucvUj2lXp7sgQANZDAy4SypLlwTlIvHxoCNneQvRa9H0IH
         P7CY4MUJAtz/6KtrWpuwZU9f3KjM/u9IyxXM3f0nfSGim5MeZUAkNis7cMl8zFlhiB
         7KSTjOif87OwMkrGMJrcDASZpBD4LuyGM3tESxFxmKlQLEWFu6bOEKNBqKrieYEGgV
         U3hgPrhIwmv0bDeSoAhFSGLAPxm+5udruXrCFszANHgcQmeiKCB/MmpazN02tYXSEf
         ylAuXE7qPZaViZ/n7p3FxWRwg+9vPSZxZNEWca9tsFjTf+xm+CF7YiNUgWrbfCX/1W
         9Y4C1tekqmAiA==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id C2A01900AD7;
        Wed,  4 May 2022 19:33:19 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Jamie Cuthbert <jamiecuthbert92@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on Allwinner A13/A20 SoC
Date:   Wed, 4 May 2022 20:33:17 +0100
Message-Id: <AC0C5D3A-9080-48D1-9478-340DB024F21A@icloud.com>
Cc:     jdelvare@suse.com, jernej.skrabec@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux@roeck-us.net, samuel@sholland.org, wens@csie.org
To:     rz@fabmicro.ru
X-Mailer: iPhone Mail (19E258)
X-Proofpoint-GUID: FQSkHrM5o5Ppy-zYGYBiJEvmRkzaD34A
X-Proofpoint-ORIG-GUID: FQSkHrM5o5Ppy-zYGYBiJEvmRkzaD34A
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=382
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040114
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Sent from my iPhone
