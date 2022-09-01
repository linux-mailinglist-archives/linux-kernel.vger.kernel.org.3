Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264005A9675
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiIAMO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiIAMOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:14:22 -0400
Received: from sonic308-11.consmr.mail.ne1.yahoo.com (sonic308-11.consmr.mail.ne1.yahoo.com [66.163.187.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D67F112EFB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1662034461; bh=1hNsVfqCY6LT7YTLp21HTSPBwyvmKxE/8qy+3OfbQzY=; h=Date:From:Subject:To:Cc:In-Reply-To:References:From:Subject:Reply-To; b=D5jqyRJcbm5ODwpKTfncxYUZqGUgSrHuEyIpQ9HJJwxPBT7mfGMy2rl4paE0vUzxoDYvQWtxlFbTFGO1uNNv0TnVu7Kr3tOaBe6t/sHqQcJ0qj5gM5bmPu1p4EfeOc/wg2azuFMkPPza7yfLR/fkGPVTitAaoctoE0M42sTHXvM=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662034461; bh=DGrXafvk06r5mx0Q9a9Vt2y9Y+hIhdCXStTis9GBvit=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=W1VQD2o9naV4tRQ6PXMzwy2suGaM/dyDypWjFHQ08g1DWoRO7y9hwz7dZPYJ4GepjvmI/j1q4MWHWq4zbk72YJU3aM2qrviTHmPb3/3CooQ2BipWBn5DWfQg0GdIp9Rh+ZtBrXEAGQbUjmnsSEgZbj8NSVJula0zO0WX06SvLLrqF7qvdRzDloHvNkgGQGNOvyBl8zwbgdWoWQk7d5Jk2yhRW0idsGN6LWj5GKZzVrnn6QgiSS6TpjhlB/G37dXNA8QoGNJVFnxkrM5dp/uoiOLn2bY5eyX25SuvzUibxOve0lQ91/pLN3eBTMhcC7KT+LZiuqnpkFStXOWO4MgwIg==
X-YMail-OSG: KQIpQUwVM1lf43XIzdjnAhO08irtbFnwvjF0cRQ8JQhQ.INm64rfYIxm_4X.RA4
 kTYuaKLGe2jon0KLudI03wh1bq2s6gqxkp0G6ev8P4IKSUVqPwJzpqB4wBge1ueIkY7tSokRPMFP
 RaX.5oSb89DIgt4CrXFBvsRPhn.Jl5RWGzlon6ND3WcbGiDGdoXG3uWC5PtbT_x.2oZib2_r7Znc
 PRe.p0BHHcmQC0z6FVmb9PemQhTzoZ2nJhsUTYxjzTTr3HqH16ES6UAqrmxD4uakLixmoBY2eNWF
 GqXB8kom.t1n0YDiFF9WqbSzJCf3.8SS9QCUdA9nJuUp3jJKZRFDOq6yeCakmWqfN9zwqsaPxkMP
 r8wPgX_3MxanRFFPSZgjMuGYVydbBWo2lNECRUDMHms9cUC58YFP4DTckP.4LbyB2uSbLPneTreH
 ViqLc95HgZBvTDI9VUO76e.km7pLIfkoH6vJMmdv9ENEw6YYEyY5HcScERIzfhcvXBL1sWYRH6OM
 5y5lesT5PutmlvnjzbQUV2gx2lbp0iLhfv_JFcUE4Z9kwNeE7ivN3DXbGdrN6kibut3NOjKIQqpD
 X_mqZxK1FNQSx95raSVDpQNqdWD_mcGH_ujpXsguI70OH0mB.ppqbJXD52ZjkjM0nxstAVz_jNM4
 oXKBaNhsxbxXiKFmpwvaBP1unw5gvK5_55c8EJDO17wqv_cJDfdKokXwKbDkQGRmCj2zOp1EBrjL
 FAjq0En2Bv4Yxd9t7sza9v8ID3re1b56xfFiXzNncYglY3hbwdfRRj0kNcivwsCTJbnUm3p2tZd0
 PvxXuEu795ntY4ypDjjD4A7zucIKK3ZcyA9Xi0HLmIQgaX4z_yzYcksCbCjTY1Cr6aZxHjEr5710
 uCuf1Lp_sVrZye5C4UstnUm_DZhm9svk7cy..Px8o4CAAZkXaiPFbtGoaMOR2DR36cNLrIA6Ny7l
 ZpuTp9ZTx7omWhzSPVaj5rBqmiSVMi7kRyKy1KJcCR_KvSdgMUUa7jhGbV5DxXdGC.ZGlyKXpOl2
 ET5rdqh18gYs7GG1j61DMZIaBrA8k4hgsQx0zMXk3EAzfo9vxGkYW65Ym8W_pd5x.y.HqI8P_q56
 kvH0t9BYgVc0neHynukGKSfcox6sO0ebPN.zHw6y6pKgQiaq_dejssHjDq9Xd5pNgtWoM9n45jpY
 xre_4qBuEZNMjuHkPpO1aIzEnYjngsBhNjwGOu8hFm2ZGQ7wuLbGUxELEjVXoRXCa1R1dpY6xa1n
 DqOmu4Ncf10M5rNEt_MUNpIykxg5zXIPGY11uBRjzQwaV_ayUl8oI7njerZpad5wZhoc6qXIGTkp
 8PnsZosqY5XhVDye7poZrvkE67aBo7qW7w_ZRNMONlRgFhpXoKhobsBEpN3tKAR_BpK3HIVLTySo
 xzUpeoiF5nQP0Kmxpc_qCbS73ft7YxvptQk9JosONu42uQAMfDDF5.aTvLl9DgO8Jp61Re0YIpGB
 KTvaq3SKWYzeOYiuVC.DICIZ5XCaDodVkCjjFC6I.YGZUpR7wjwS9zynPnSZdo9RhQtzDrqo_2Fv
 iOzI9hB5pjw3Pqsawkj6oIQwMtxwcmzmDYh50PdS5PjMQ9VnIJWAD4mnth8YtpJjELaQ5Qv6fNNB
 XGUV_bLJ9sVyD8LtIOoLy6iRwE7UilMJxJ7WpaldZG40G0eWwdrQ5WUmSgEI1BgCtiBj2CGigq1b
 Jr7kW_URHbyxBV.YygCaTn5WrBWa0FZ51uqRLZiMOErA_VOWNjOMNTcmSlPje2bh9rKusTbVoiqB
 0VpDNJoKZ62C1YphElWufc9vjSjDrf3wppA9cBn_AT9BKGFQC9x8SBZq3xY8hG.6QvAE3hQ4pJj4
 wSVyRFTrtmgaxuclusH9TZKNn.l6L972UEC.aqHDlq.4z9DjBQKwxe5mEzUZQ34K.lcp6DJQdyGv
 4yz15e3c1IJIR_27QUEnrFxgaeNRyKt34JiPgnZMj4rmH2nghFJ9o2J3vWWeAoUuf39Usno15I69
 kFWzj1NkFTyeE8v5FWR9jAaG8
X-Sonic-MF: <pheonix.sja@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 1 Sep 2022 12:14:21 +0000
Received: by hermes--production-ne1-7fdb795c57-j45rv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a9daef07438b8223431cc67a31a2c457;
          Thu, 01 Sep 2022 12:14:18 +0000 (UTC)
Date:   Thu, 01 Sep 2022 08:14:11 -0400
From:   Steven J Abner <pheonix.sja@att.net>
Subject: Re: thermal driver patch
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Message-Id: <NZ5JHR.JGO592OT0D961@att.net>
In-Reply-To: <be354f9e-47c7-bd6e-c570-e7364858ced4@linaro.org>
References: <DL9RGR.8W3XFSCFFYXI2.ref@att.net> <DL9RGR.8W3XFSCFFYXI2@att.net>
        <0f961ea6-4948-0b7a-e01d-d62ca4065af8@infradead.org>
        <L9MDHR.JVBXTJ2L6TPP2@att.net>
        <cf3a3cbd-c189-a120-124f-98d6adac058d@infradead.org>
        <be354f9e-47c7-bd6e-c570-e7364858ced4@linaro.org>
X-Mailer: geary/3.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Sep 1, 2022 at 05:59, Daniel Lezcano 
<daniel.lezcano@linaro.org> wrote:
> Could it be related to this bug?
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=201761
> 
> Is it possible to give the thermal zone 'type'

Did verify that that my thermal_zone0 is my wifi:
used lm-sensor and cat /sys/class/thermal/thermal_zone0/temp
along with wifi load to heat to temps different then others to check 
outputs.
The above mentioned bug page could have lead to this, I can't say or 
track.

Prefix the following with I'm not an expert, just info provider:

My guess is not supposed to be calling function during initial kernel 
loading, based on following:

from thermal_core.c:
18:
#include <linux/thermal.h>

397:
static void update_temperature(struct thermal_zone_device *tz)
{
	int temp, ret;

	ret = thermal_zone_get_temp(tz, &temp);
	if (ret) {
		if (ret != -EAGAIN)
			dev_warn(&tz->device,
				 "failed to read out thermal zone (%d)\n",
				 ret);
		return;
	}

	mutex_lock(&tz->lock);
	tz->last_temperature = tz->temperature;
	tz->temperature = temp;
	mutex_unlock(&tz->lock);

	trace_thermal_temperature(tz);

	thermal_genl_sampling_temp(tz->id, temp);
}

from linux/thermal.h:
429:
static inline int thermal_zone_get_temp(
		struct thermal_zone_device *tz, int *temp)
{ return -ENODEV; }


compiler should then read:
static void update_temperature(struct thermal_zone_device *tz)
{
	int temp, ret;

	ret = -ENODEV;
	if (ret) {
		if (ret != -EAGAIN)
			dev_warn(&tz->device,
				 "failed to read out thermal zone (%d)\n",
				 ret);
		return;
	}

however did find with extra search:
in /drivers/thermal/thermal_helpers.c:
78:
int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
and
115:
EXPORT_SYMBOL_GPL(thermal_zone_get_temp);


so is this bootup vs system hand off?
where bootup call thermal_zone_get_temp() shouldn't occur?

Steve


