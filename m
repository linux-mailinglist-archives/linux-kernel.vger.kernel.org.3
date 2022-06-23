Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3971557681
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiFWJVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiFWJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:21:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2063.outbound.protection.outlook.com [40.92.91.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2854665D;
        Thu, 23 Jun 2022 02:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fnw37BoTSJiqmFqkWZGpVd9pRFOgZcWGZ6+IYV/VH45XMRxBCQxchzVg4ZVX9kfqLdbiG1IeH9kQwPl37maKMSKdMGwZyRltXHpp/tnJgMyBnS4qj5n+Rj7hezxHKI3UGlofjRnRrp+p1VdGMdMrsLwlFNMuyg1w9Dc9FWyyH7cw+YCU8hYTpHPy//BZGmNzNFpsa/d+1BEIJ/UpcQEy+iTyL7br3mXDfQdE1CZcivuief9W9IopBdRgme0mn/Daj3N7jEpFOGahDWzY+vqnZoxZnygj0/6UUPIuL+3vQmtRWmtWwfs6v5Avuf2AD5VoanL6vLDBGx5CsXO1zYt7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXaIHHZyQdtUA5aL7bXuTGvpDAbuWMng3Bzaenv9318=;
 b=WsxXPrxzgMSY9VCVM6olL4hwrMmHReaEzZFaMgW881PkE7HOlsPgVxJ3mwXrmyNNcnujhtaq0T2b9nAzTHkpmwomxlF0NJb2Rqn88LpITNl7n9gVZAOUeqpZ9f5XM5pt9d4Lp3zLIeMBneNuDxc/2pdbEATaqOQishkE7mAgsBsp1cMlfZbN5tV1//VkL8703PGXutmFS6MFwRU4AUZvh50ZDeAIyAE+JS+DXZTPSBC4Am9VDg+WRZNGC5Ji0Sv86XDZvHBNxNIZEliEM2hklv5xE3bAqeLg9QDTN2gkqhyO4nL8UQ6in+VA5T+2HfYq9gCHo4eFoSdECC9KfKKfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXaIHHZyQdtUA5aL7bXuTGvpDAbuWMng3Bzaenv9318=;
 b=ehMelG4YpHRy/Y78gXywBJ9EdeumDyGxyNFJpHuyKkNqi3ra+jcfp3HjbBV0Rbi+MfGEbkYq8lPQPmQefgA4JI4dPxqf1dgr2B8Z24akFpVyVOiyxYkbTMmjGBsKALNiLC3qbqH+4twIaK34eXfJfxA72DxrIVILTOJgI44sck0wa9O5BClkHXyweLfDQb0qJabZtUdQCNpKrw+fplG0q497yMKZOCwiM+As60OjfJHn07gbAyxyGVNajIAfUonj/37fCPJVowPa0wo7i3RIgtn5zMMkZC0gm3ztO2TsPe2erWM5oJAzwGqdns/VZwwL/6FFAYto8TS3ttnsQjPheQ==
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:c2::10)
 by HE1P18901MB0139.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Thu, 23 Jun
 2022 09:21:17 +0000
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d]) by PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d%6]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 09:21:17 +0000
From:   Saud Farooqui <farooqui_saud@hotmail.com>
To:     mathieu.poirier@linaro.org
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Saud Farooqui <farooqui_saud@hotmail.com>
Subject: [PATCH v1] rpmsg: strcpy is not safe, use strscpy_pad() instead
Date:   Thu, 23 Jun 2022 14:20:47 +0500
Message-ID: <PA4P189MB14210AA95DCA3715AFA7F4A68BB59@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622174616.GD1606016@p14s>
References: <20220622174616.GD1606016@p14s>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [pDbeWmvhSCi9LLwi+kgDjzYmYo2z3ZvF]
X-ClientProxiedBy: DX1P273CA0007.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::12) To PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:c2::10)
X-Microsoft-Original-Message-ID: <20220623092047.18053-1-farooqui_saud@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a1f4327-6578-46ea-6863-08da54f9ba25
X-MS-Exchange-SLBlob-MailProps: gjx25WM8ZNWiRXOVlgeuQvnFhL6fwZ19DTNuvcngGSe5IbhzkogMTqPQMZNQ3ij9CMWcmdROvgBIl5cyCqVLpB7VK0w0akVQYzWcb0Lm4JZYNu3njpJdyCuIpsiljQ0DvbC1FSWw0KdW6MDcI12uqYEvBVvb7Y/leT5JdaKtZxL1ch29qhiTIVCzfoxuLhGeZzbNphDLAvoMI5WzOAXJsXFqLA+tMaiN9Rh504WqsN9JCoOYlifP6nt4IGqQfIOZHbE7j/t34Q7MDx/xPsasAmKHjCw/uv15o8f8bBRsCKIFQiMGgvxhfnid4rasrJkF12gnGyaX0VsxJZmyoUdkbUsEo6BavYhu4HtAdomAn3UNTfQzt1U8DthBwsre6GBUcTS5W2mfniY0h9cb7NLLu418JiNmnQkyP1zQ+ypyxMb53X8wElD0vqIGK8SFo0om2DOUGWxKGS3BVQha3x8PxILyurnT9y7EL6xXfR5IEgxuh9eaBu8RYST8f3v2RJhLzrctiwmhgpKpH+br0k+tRiSNfKMHQ0IkD5zdYHiGR2wUEiIQg3jR9zllWD+BSBnkLNR2+fjG3rVt37BjqIQ0X5HvnDfwd7LRpMAJNvXE/cow6ZOOoOBD938OivFVc8FQ1iCJw6JMcH+dVFDZ7TD3NHYRNIq0yLvNUZ2TPZrTSCD9Efq5j9naSIQEIWuEXP+T2UUz1jzTfodkqmMwRVnULJIJG+oN25DixQWHsBBoi1A=
X-MS-TrafficTypeDiagnostic: HE1P18901MB0139:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuDPYQH/azczPTxegWbdd5lKJ49IO81wQOP8Fs+NuUAq02/yQ6Wi3DnbcttECTrqDp5fmQKz3B4xp4rTVtBgQtuhMMfpeWOzCNwB63QQZin9rCgGvn6sixBmQ3uI5rZHt4CykEb4JFpLi8PaM9rwZO9q6ogZJY1h4pv2IJ0NxiCBj6g/s6ipR1KQT39C4seOUb6ox3rUIHQOl7KRr5q6Sx+Yl0lUFUwTAGAZHNyH3hfOfAffQEiu2DrJUkmjSs40IKJn2nlryuW06jH+FEUaTMPjPN4aMO0OSn3g1ehxt0eTbPM2Z5ZkNSYBNOFZ/1xCHH9RgzhJadTKE2gvhP69qZq2AHurwCw5DmXolCIVwNhjuO2cwF+Xuh3DabfPSnunoGRKcyLaxY4TlNGuT0sAQ4jmR3SEbgcEaFK7fw49uDdnYTAHj9hsmZ5zX0joTqhBu42Ie1sNjVrg1f3H+IlowW92RQQAXlOK1GnjoSxRnaGzDspgxPdBdaLaVCm1d+MkOXbBhsCeehBfUXVwByUHybBKzAzHgEM9ABCQffLs/WASKTzCZYJ5rQ2U0c/0E5ZLwLLDZpIIGMmz0PpbLCt7e6CyC8c45z6aqrsRh6QbUb3gYKJh+dcNS9F23k91F6qr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xATuph6Exn9aIANkMVHTfFiQLFNZObQyfDbcByF9sGpVzEZQmBVa1aiw4D/T?=
 =?us-ascii?Q?roS11PzKYgOLXYCoi7GchWmooqBZuCp4sjCksW51IEjycDW9EnEuYv6Hr6nf?=
 =?us-ascii?Q?Cw/cLrcnrakVCVVGy2MkLWE4LoW9q+bkI3poB3hZbGP++JqQ5I2d4TNlmff/?=
 =?us-ascii?Q?siJTocrjCN09jN1bK/qTyBHwykXKPhULNJXgWuHjh9v0d1DfhIc1B/t9IufZ?=
 =?us-ascii?Q?LvAZghDHufLnWs3RX1GOWKpkuyNeQ0lLg3zYl8M8swHpVwUnGEW6R+9+xgHg?=
 =?us-ascii?Q?9mLHKWxrfi73OTBCqrAiAFfsOl8fI9vH4eBQBJ2KY0CjHz64oCXlPMc8Vxwh?=
 =?us-ascii?Q?iiBlOYoae232ALYsw1sIl85St2wCeWazQXs5EnTqCVtLdIYzY/RB9D8w+0pQ?=
 =?us-ascii?Q?RNqPM8ODweiD5jePqo7ojmAkzgzpN6XJInrYp6gHiYl0a+T1GTC/dVLVcaqs?=
 =?us-ascii?Q?3tHPU2QnaoX/Fv+5507/7k3GMTCSQolZphZy9tooSdDD/pqSsoGywugvjpzZ?=
 =?us-ascii?Q?eAUmOkZf89D3gYiYD3pGK+Pk44+TZ/WNGl0re+Tm5RrSw6bWtctkO1G6fTno?=
 =?us-ascii?Q?GoXvfrFRpJwIGqW1GgYWqaWb3jyNiOGKkyA4xbdO1BbQZD/fYI2mrqPZYwrX?=
 =?us-ascii?Q?Tg5BlCz14UJRyOGf44rHver2S9LM8W7FtJh3gkQhQrdgVhE0vVMpTJQOhr2Y?=
 =?us-ascii?Q?+ykbghABMUaFdwDm4ZatxKZHZckHOp5jEFPKoXjF3kBENIwW48RglV79sE+w?=
 =?us-ascii?Q?oMm4QURtDy0Hc+bQ9OOrGeAHTVRswkymGQb3PhmpETiV4sEaeAiKAZYtwk05?=
 =?us-ascii?Q?PGqQqqqYKbTYX6HP5xD7S1b1rMILKGtBvpmxw0ywvNJ5ldXLvgwj6HcwYrdm?=
 =?us-ascii?Q?xMxHNwydjOXNeZZ66Fq9aQukhTILKa13zJWJgwtVA9jhUlzFkK0hQH1xyl9g?=
 =?us-ascii?Q?WmF+d5pTRwOX4IOrRJLr24QOZqGWcc7ytSkdRTCKCTm+B1mowFffINEahzF3?=
 =?us-ascii?Q?alLLLN1U4qC0bve5SgqAeeCfPoADiRHYmwUTyYUlrBKO/5KnE4E/WRFIgXq5?=
 =?us-ascii?Q?sUOIAqIQ6eQuGGM6vqZdT4eVPdPxg1mA2AgG6kqL0Eg0yWKHd3osBy5+N2RA?=
 =?us-ascii?Q?2bIr47nhDkNDs5spbulWIj5+umWoyfKP1n6ZLDK9LQVrdl4sgAzZP2JYtmPj?=
 =?us-ascii?Q?gyJEWco66lq9WzqKiN5LUr03QeMyZGXa2iw7GDxPjOZuSkloFc30zrruGzwb?=
 =?us-ascii?Q?8LsJ98MMDr4G+DUJD6of+5d474h0ZuhOSm/x2Avp73Py0dpni3KlHqrSEDY9?=
 =?us-ascii?Q?L5WHDRLSVr2o+kaEDbQTgByP/4YbpEMAEZ5MyNgeeF3V/tMzJNC8J40GClnX?=
 =?us-ascii?Q?b1gH3gEeV/P+EoUgGNYJwa6Vzg2dmDVoIyi/fukk6Il3hoSeu007if6M5gzO?=
 =?us-ascii?Q?OQWIyHPFVA8Niz2QZyev8x2WJmFzMirU?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1f4327-6578-46ea-6863-08da54f9ba25
X-MS-Exchange-CrossTenant-AuthSource: PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 09:21:17.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P18901MB0139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace strcpy() with strscpy_pad() for copying the rpmsg
device name in rpmsg_register_device_override().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Saud Farooqui <farooqui_saud@hotmail.com>
---
 drivers/rpmsg/rpmsg_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 290c1f02da10..a4bad4b00414 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -604,7 +604,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
 	int ret;
 
 	if (driver_override)
-		strcpy(rpdev->id.name, driver_override);
+		strscpy_pad(rpdev->id.name, driver_override, RPMSG_NAME_SIZE);
 
 	dev_set_name(dev, "%s.%s.%d.%d", dev_name(dev->parent),
 		     rpdev->id.name, rpdev->src, rpdev->dst);
-- 
2.25.1

