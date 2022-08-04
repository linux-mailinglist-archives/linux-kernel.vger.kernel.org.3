Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D388458A3F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbiHDXjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiHDXjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:39:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D62E70E55;
        Thu,  4 Aug 2022 16:39:10 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A914B6601BF8;
        Fri,  5 Aug 2022 00:39:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659656348;
        bh=d6Yj8quN+qhReF+CXCReEHbUa8q5Q9aLROw+IgGnAOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ffw04upiyLlesxOxtKFs7rT4WrInmPhkgXCQZrlk1dDiSneFjp5ya+4MpdDWUzZH9
         BH5aSxDIKmkYgV4wi9LOWgKLwbd2pEG7lfrb9vtXVzp6rHbSVmrOPz5Z/vXQPWhvlz
         7eWbrir8r1+bMZM8xLfMGG6S/fAE3p0AdHiJW62uo4LZaqrjrFvtuCPscoU7XoD+lG
         GC48y/JAIppPY6gsLQzNFmY+lkwZB396XRnksov+DOvp52SrJ4C5n0/DHVRw8a89mV
         EPRm8I8hktbdt+Siizdqob9O97f6vSg8ZKCl2KFHGtf1/hdelCef8ZVG8Wa8UBF5NN
         JZckzzepo2G6Q==
Date:   Thu, 4 Aug 2022 19:39:02 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     bchihi@baylibre.com
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: Re: [PATCH v8.1, 4/7] thermal: mediatek: Add LVTS driver for mt8192
 thermal zones
Message-ID: <20220804233902.h3hjpm56kzk663un@notapiano>
References: <20220804130912.676043-1-bchihi@baylibre.com>
 <20220804130912.676043-5-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220804130912.676043-5-bchihi@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 03:09:09PM +0200, bchihi@baylibre.com wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add a LVTS V4 (Low Voltage Thermal Sensor) driver to report junction
> temperatures in MediaTek SoC mt8192 and register the maximum temperature
> of sensors and each sensor as a thermal zone.
> 
> Signed-off-by: Yu-Chia Chang <ethan.chang@mediatek.com>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>

You should have a Co-developed-by tag for each person that wrote the code [1].

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> ---
[..]
> --- /dev/null
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
[..]
> +static int prepare_calibration_data(struct lvts_data *lvts_data)
> +{
[..]
> +	lvts_data->coeff.golden_temp = cal_data->golden_temp;
> +	dev_dbg(dev, "golden_temp = %d\n", cal_data->golden_temp);
> +	offset = snprintf(buffer, sizeof(buffer), "[lvts_cal] num:g_count:g_count_rc ");
> +	for (i = 0; i < lvts_data->num_sensor; i++)
> +		offset += snprintf(buffer + offset, sizeof(buffer) - offset, "%d:%d:%d ",
> +			i, cal_data->count_r[i], cal_data->count_rc[i]);

Like Angelo already mentioned [2], you're not using this string for anything, so
just remove the code.

[2] https://lore.kernel.org/linux-mediatek/82f6cd96-65e2-57f7-b7c5-05c111874087@collabora.com/

> +
> +	return 0;
> +}
[..]
> +int lvts_device_read_count_rc_n_v4(struct lvts_data *lvts_data)
> +{
[..]
> +	offset = snprintf(buffer, sizeof(buffer), "[COUNT_RC_NOW] ");
> +	for (i = 0; i < lvts_data->num_sensor; i++)
> +		offset += snprintf(buffer + offset, sizeof(buffer) - offset, "%d:%d ", i,
> +			cal_data->count_rc_now[i]);

Again, just formatting a string and throwing it away, please just drop the code.

> +
> +	return 0;
> +}
[..]
> +int lvts_resume(struct platform_device *pdev)
> +{
> +	struct lvts_data *lvts_data;
> +	int ret;
> +
> +	lvts_data = (struct lvts_data *)platform_get_drvdata(pdev);
> +	ret = lvts_init(lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

You have a bug in your resume path somewhere. I get this error during resume on
mt8192-asurada-spherion:

<1>[  237.487428] Unable to handle kernel write to read-only memory at virtual address ffffc15096e491c0
<1>[  237.496663] Mem abort info:
<1>[  237.499794]   ESR = 0x000000009600004e
<1>[  237.504334]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[  237.509982]   SET = 0, FnV = 0
<1>[  237.513444]   EA = 0, S1PTW = 0
<1>[  237.516911]   FSC = 0x0e: level 2 permission fault
<1>[  237.522041] Data abort info:
<1>[  237.525263]   ISV = 0, ISS = 0x0000004e
<1>[  237.529458]   CM = 0, WnR = 1
<1>[  237.532739] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041782000
<1>[  237.539754] [ffffc15096e491c0] pgd=100000023ffff003, p4d=100000023ffff003, pud=100000023fffe003, pmd=0060000041200f81
<0>[  237.550821] Internal error: Oops: 9600004e [#1] PREEMPT SMP
<4>[  237.556669] Modules linked in: af_alg mtk_vcodec_dec_hw snd_soc_hdmi_codec panel_edp mtk_vcodec_dec v4l2_vp9 v4l2_h264 mtk_vcodec_enc btusb mtk_vcodec_common btrtl videobuf2_dma_contig uvcvideo btintel videobuf2_vmalloc mtk_vpu btmtk videobuf2_memops v4l2_mem2mem mt7921e btbcm cdc_ether usbnet videobuf2_v4l2 mt7921_common bluetooth crct10dif_ce videobuf2_common r8152 mt76_connac_lib videodev ecdh_generic ecc mc mt76 mac80211 sbs_battery cros_usbpd_charger cros_usbpd_logger cros_ec_chardev libarc4 pwm_cros_ec anx7625 snd_soc_rt5682_i2c elan_i2c snd_soc_rt5682 cros_ec_typec snd_soc_rl6231 drm_dp_aux_bus typec drm_display_helper panfrost mediatek_drm drm_cma_helper rtc_mt6397 drm_shmem_helper phy_mtk_mipi_dsi_drv gpu_sched mt8192_mt6359_rt1015_rt5682 drm_kms_helper pwm_mtk_disp pwm_bl snd_soc_rt1015p snd_soc_mt8192_afe snd_soc_dmic snd_soc_mtk_common cfg80211 rfkill drm fuse backlight ip_tables x_tables ipv6
<4>[  237.637538] CPU: 1 PID: 533 Comm: bash Tainted: G        W          5.19.0-rc8-next-20220725+ #254
<4>[  237.646781] Hardware name: Google Spherion (rev0 - 3) (DT)
<4>[  237.652539] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
<4>[  237.659778] pc : lvts_device_enable_and_init+0xdc/0xf0
<4>[  237.665198] lr : lvts_device_enable_and_init+0xc8/0xf0
<4>[  237.670609] sp : ffff8000098eb9b0
<4>[  237.674188] x29: ffff8000098eb9b0 x28: 0000000000000000 x27: 0000000000000003
<4>[  237.681609] x26: ffff41b141151010 x25: ffffc15097260c50 x24: 0000000000000000
<4>[  237.689028] x23: 0000000000000038 x22: 0000000000000001 x21: 000000008502fc00
<4>[  237.696448] x20: ffffc15096e49188 x19: 0000000000000003 x18: 0000000000000000
<4>[  237.703867] x17: 0000000000000001 x16: ffffc15095cc9838 x15: 00000000000001ca
<4>[  237.711287] x14: 0000000000000002 x13: 0000000000000000 x12: 000000000000045d
<4>[  237.718706] x11: 0000000000000000 x10: 00000000000027d0 x9 : ffffc15095d81d18
<4>[  237.726126] x8 : ffffc150974eb008 x7 : ffff41b15fdc2f80 x6 : ffffc15095ce58c0
<4>[  237.733545] x5 : 0000000000000000 x4 : ffff8000098eb6f0 x3 : 0000000000000000
<4>[  237.740963] x2 : 7ec5fa8849bae900 x1 : 7ec5fa8849bae900 x0 : 0000000000000014
<4>[  237.748383] Call trace:
<4>[  237.751091]  lvts_device_enable_and_init+0xdc/0xf0
<4>[  237.756155]  lvts_init+0x180/0x520
<4>[  237.759824]  lvts_resume+0x1c/0x78
<4>[  237.763494]  platform_pm_resume+0x5c/0x80
<4>[  237.767777]  dpm_run_callback+0x80/0x2e8
<4>[  237.771972]  device_resume+0x90/0x1c0
<4>[  237.775904]  dpm_resume+0x110/0x470
<4>[  237.779663]  dpm_resume_end+0x20/0x38
<4>[  237.783596]  suspend_devices_and_enter+0x1e4/0xb90
<4>[  237.788662]  pm_suspend+0x270/0x318
<4>[  237.792419]  state_store+0x94/0x120
<4>[  237.796176]  kobj_attr_store+0x18/0x30
<4>[  237.800198]  sysfs_kf_write+0x54/0x80
<4>[  237.804131]  kernfs_fop_write_iter+0x128/0x1c0
<4>[  237.808845]  vfs_write+0x39c/0x510
<4>[  237.812517]  ksys_write+0x74/0x100
<4>[  237.816187]  __arm64_sys_write+0x24/0x30
<4>[  237.820380]  invoke_syscall+0x4c/0x110
<4>[  237.824401]  el0_svc_common.constprop.0+0x68/0x128
<4>[  237.829464]  do_el0_svc+0x34/0xc0
<4>[  237.833048]  el0_svc+0x4c/0xc0
<4>[  237.836371]  el0t_64_sync_handler+0xb8/0xc0
<4>[  237.840824]  el0t_64_sync+0x18c/0x190
<0>[  237.844759] Code: 11000673 6b13001f 54fffaa8 52800280 (b9003a80)
<4>[  237.851129] ---[ end trace 0000000000000000 ]---

Thanks,
Nícolas
