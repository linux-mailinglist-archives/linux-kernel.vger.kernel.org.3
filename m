Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77446591ADD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 16:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbiHMOWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 10:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiHMOWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 10:22:20 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7992421E3E
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 07:22:18 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id c185so4091734oia.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vFPpPAQ/8/lpQuPzXEpzSPM3cO6f+pICFe1CKQcfRFw=;
        b=jF2Q4SG3+J6Gr0Gz1yexq9cWVuy/iojtNtkMbnXMmtS/AuoRYuKFL1exLUjN1w5Ulr
         7AvlGbKBKJgflYWu9j16YRYkSImDZvwe5AnOEZX/0cpzBfWLBwIpIuHHLfnLiWXqczEC
         CK5MKiuAEVWSxnFBo6QnpJZR60rxAhOMUCk0pUSuu4VnGWf2EV64u0ovaydSI23XyXx0
         CgUNWR3aK0MY877GByjK/fruZ1UosB1W3XOvLh1Nsy2P8iOYxYFFm0XshFXA3K1vgvcW
         zIkUVk9MMLPfSkeutDoJ/RvoMze47+w4TUQx0GekMJUHEpUjQHD2cUDXn1fXigN74lTQ
         dD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vFPpPAQ/8/lpQuPzXEpzSPM3cO6f+pICFe1CKQcfRFw=;
        b=yCsk4gaw+ae0EM8zYK0cwXwLgcsMz71vPsBwNoxmqb0y+XeiFhFvryHged1qd2f9bu
         9dS1Y22koOxCstmOQV4H9OfuK+tG/jCq+NOdPP0CUH64VQSWePxZuvMyJZxhwCKjBrrP
         PZooLoYF+Qgx6AqrUkrr/4TdGP/3lrmVkb2UqbOgE6D0vStoshbjJ3Q2aCQZcsrQIAQ0
         Ovf3ldTfoUJodczKoZJ+mt276m8Gt66FoQ5s4cRZ6i4/awxvYM8FelRikOe8yJnroipk
         8aYmoQmnXAk9ti7xqUMMX5N9gthdytuJB0ThhCsVmOvgj5RsigNjs0pM8cJbaanL0s31
         EqFw==
X-Gm-Message-State: ACgBeo18WAQACferAq5fph8dBmfzjGo5KfLcHrSBskE7eBUdHvHHTSPH
        EEeGuaA1rfmU48ZJiZabLWFvquJb+y7EhZHYypEBPg==
X-Google-Smtp-Source: AA6agR5Ys9OZj5h44/U6akNLjfD2s2l+j7iSBni3yq8eU4h/DsNIjGUwN8lgEdUCByrilGa178en7uDnfn1mVGUSfAE=
X-Received: by 2002:a05:6808:3:b0:343:7d5c:ac50 with SMTP id
 u3-20020a056808000300b003437d5cac50mr2755767oic.108.1660400537719; Sat, 13
 Aug 2022 07:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <YtDxdBLgvAHG8IhG@matsya>
In-Reply-To: <YtDxdBLgvAHG8IhG@matsya>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Sat, 13 Aug 2022 19:51:41 +0530
Message-ID: <CAMi1Hd3GWVCOzkwWm6bpkGsrZcr5jEPzPkOWDddm2gTE=vVCaA@mail.gmail.com>
Subject: Re: [GIT PULL]: soundwire updates for v5.20-rc1
To:     Vinod Koul <vkoul@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 at 10:18, Vinod Koul <vkoul@kernel.org> wrote:
>
> Hello Greg,
>
> Please pull to receive updates for soundwire subsystem. This is smallish
> request this time but few important changes:
>
> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
>
>   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.20-rc1
>
> for you to fetch changes up to 3f4a70268d54c41117bc4e1bed0ba4be756735a8:
>
>   soundwire: qcom: Enable software clock gating requirement flag (2022-07-06 22:14:51 +0530)
>
> ----------------------------------------------------------------
> soundwire updates for 5.20-rc1
>
>  - Core: solve the driver bind/unbind problem and remove ops pointer
>  - intel: runtime pm updates
>  - qcom: audio clock gating updates and device status checks
>
> ----------------------------------------------------------------
> Pierre-Louis Bossart (4):
>       soundwire: bus_type: fix remove and shutdown support
>       soundwire: revisit driver bind/unbind and callbacks
>       soundwire: peripheral: remove useless ops pointer
>       soundwire: intel: use pm_runtime_resume() on component probe
>
> Srinivas Kandagatla (1):
>       soundwire: qcom: Check device status before reading devid
>
> Srinivasa Rao Mandadapu (3):
>       soundwire: qcom: Add support for controlling audio CGCR from HLOS
>       soundwire: qcom: Add flag for software clock gating check
>       soundwire: qcom: Enable software clock gating requirement flag

Hi, these soundwire qcom patches broke DB845c running AOSP. I see:

[    9.800123][    T1] init: Loading module /lib/modules/wcd934x.ko with args ''
[    9.808192][    T1] wcd934x-slim 217:250:1:0: there is not valid
maps for state default
[    9.876483][    T1] wcd934x-slim 217:250:1:0: WCD934x chip id major
0x108, minor 0x1
[    9.889819][    T1] wcd934x-slim 217:250:1:0: type registers are
deprecated; use config registers instead
[    9.902893][    T1] wcd934x-slim 217:250:1:0: missing
qcom,mbhc-buttons-vthreshold-microvolt entry
[    9.917807][    T1] wcd934x-gpio wcd934x-gpio.3.auto: DMA mask not set
[    9.925745][    T1] qcom-soundwire wcd934x-soundwire.4.auto: DMA mask not set
[    9.939595][    T1] qcom-soundwire wcd934x-soundwire.4.auto: Failed
to get audio_cgcr reset required for soundwire-v1.6.0
[    9.952137][    T1] wsa881x-codec sdw:0:0217:2010:00:2:
nonexclusive access to GPIO for powerdown
[    9.961450][    T1] ------------[ cut here ]------------
[    9.966801][    T1] WARNING: CPU: 7 PID: 1 at
drivers/reset/core.c:334 reset_control_reset+0xfc/0x138
[    9.976103][    T1] Modules linked in: wcd934x(+) videocc_sm8250
videocc_sdm845 ves1x93 ves1820 venus_enc venus_dec
videobuf2_dma_contig venus_core v4l2_mem2mem ufs_qcom tuner_simple
tuner_types tua9001 tua6100 ts2020 tea5767 tea5761 tda9887 tda8290
tda827x tda826x tda8261 tda8083 tda665x tda18271c2dd tda18271 tda18250
tda18218 tda18212 tda10086 tda10071 tda1004x tda10048 tda10023
tda10021 tc90522 syscon_reboot_mode stv6111 stv6110x stv6110 stv0910
stv090x stv0900 stv0367 stv0299 stv0297 stv0288 stb6100 stb6000
stb0899 spmi_pmic_arb spm spi_qup spi_qcom_qspi spi_pl022
spi_geni_qcom sp887x sp2 soundwire_qcom socinfo snd_soc_wsa881x
snd_soc_wcd934x snd_soc_wcd9335 snd_soc_wcd_mbhc snd_soc_sm8250
snd_soc_sdm845 snd_soc_rt5663 snd_soc_rl6231 snd_soc_qcom_common
snd_soc_max98927 snd_soc_lpass_wsa_macro snd_soc_lpass_va_macro
snd_soc_lpass_macro_common snd_soc_hdmi_codec snd_soc_dmic smsm smp2p
slim_qcom_ngd_ctrl si21xx si2168 si2165 si2157 sdhci_msm s921 s5h1432
s5h1420 s5h1411
[    9.976323][    T1]  s5h1409 rtl2832_sdr rtl2832 rtl2830 rtc_pm8xxx
rpmsg_ns rpmsg_char rpmhpd rmtfs_mem reset_qcom_pdc reset_qcom_aoss
regmap_slimbus slimbus regmap_sdw soundwire_bus r820t qt1010 qrtr_tun
qrtr_smd qrtr_mhi qrtr qnoc_sm8250 qnoc_sdm845 qm1d1c0042 qm1d1b0004
qcom_usb_vbus_regulator qcom_tsens qcom_spmi_regulator qcom_rpm
qcom_q6v5_wcss qcom_q6v5_pas qcom_q6v5_mss qcom_q6v5_adsp qcom_q6v5
qcom_sysmon qcom_pil_info qcom_hwspinlock qcom_glink_rpm qcom_aoss
qcom_wdt qcom_spmi_temp_alarm qcom_spmi_pmic regmap_spmi
qcom_spmi_adc5 qcom_spmi_adc_tm5 qcom_vadc_common qcom_rpmh_regulator
qcom_pon reboot_mode qcom_pmic_typec qcom_pdc qcom_ipcc
qcom_cpufreq_hw qcom_apcs_ipc_mailbox q6prm_clocks q6prm q6asm_dai
q6routing q6asm q6apm_lpass_dais q6apm_dai snd_q6apm q6afe_dai
q6afe_clocks q6adm snd_q6dsp_common q6afe q6core pm8941_pwrkey
pm8916_wdt pinctrl_spmi_mpp pinctrl_spmi_gpio pinctrl_sm8250
pinctrl_sm8250_lpass_lpi pinctrl_sdm845 pinctrl_msm pinctrl_lpass_lpi
[   10.063197][    T1]  phy_qcom_usb_hs ulpi phy_qcom_snps_femto_v2
phy_qcom_qusb2 phy_qcom_qmp_usb phy_qcom_qmp_ufs phy_qcom_qmp_pcie
phy_qcom_qmp_pcie_msm8996 phy_qcom_qmp_combo or51211 or51132
ohci_platform ohci_pci ohci_hcd nxt6000 nxt200x nvmem_qfprom mxl692
mxl5xx mxl5007t mxl5005s mxl301rf mt352 mt312 mt2266 mt2131 mt20xx
mt2063 mt2060 msm_serial msm msi001 mn88473 mn88472 mn88443x
michael_mic mdt_loader mcp251xfd mc44s803 mb86a20s mb86a16 max2165
m88rs6000t m88rs2000 m88ds3103 lpass_gfm_sm8250 lontium_lt9611uxc
lontium_lt9611 lnbp22 lnbp21 lnbh29 lnbh25 lmh llcc_qcom lgs8gxx
lgs8gl5 lgdt330x lgdt3306a lgdt3305 lg2160 l64781 ix2505v itd1000
it913x isl6423 isl6421 isl6405 icc_rpmh icc_osm_l3 icc_bcm_voter
i2c_rk3x i2c_qup i2c_qcom_geni i2c_mux_pca954x i2c_dev
i2c_designware_platform i2c_designware_core horus3a helene
gpucc_sm8250 gpucc_sdm845 gpu_sched gpio_wcd934x gpio_regulator
gcc_sm8250 gcc_sdm845 fc2580 fc0013 fc0012 fc0011 fastrpc
extcon_usb_gpio ec100 e4000 dvb_pll
[   10.149490][    T1]  ds3000 drxk drxd drx39xyj drm_dp_aux_bus
drm_display_helper display_connector drm_kms_helper dispcc_sm8250
dispcc_sdm845 dib9000 dib8000 dib7000p dib7000m dib3000mc
dibx000_common dib3000mb dib0090 dib0070 cxd2880 cxd2880_spi cxd2841er
cxd2820r cxd2099 cx24123 cx24120 cx24117 cx24116 cx24113 cx24110
cx22702 cx22700 cqhci cpr clk_spmi_pmic_div clk_rpmh qcom_rpmh cmd_db
clk_qcom bcm3510 bam_dma virt_dma ax88179_178a au8522_dig
au8522_decoder au8522_common ath11k_pci mhi ath11k_ahb ath11k
ath10k_snoc qcom_common qcom_glink_smem qcom_glink qcom_smd smem
ath10k_pci ath10k_core ath atbm8830 ascot2e arm_smmu qcom_scm apr
pdr_interface qmi_helpers rpmsg_core af9033 af9013 i2c_mux a8293
[   10.298727][    T1] CPU: 7 PID: 1 Comm: init Not tainted
5.19.0-mainline-14184-g69dac8e431af #1
[   10.307490][    T1] Hardware name: Thundercomm Dragonboard 845c (DT)
[   10.313896][    T1] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
[   10.321608][    T1] pc : reset_control_reset+0xfc/0x138
[   10.326875][    T1] lr : qcom_swrm_init+0x44/0x190 [soundwire_qcom]
[   10.333205][    T1] sp : ffffffc00805b480
[   10.337248][    T1] x29: ffffffc00805b480 x28: 0000000000000000
x27: ffffff8088144880
[   10.345139][    T1] x26: 0000000000000000 x25: ffffff80fd7f95f0
x24: 0000000000000001
[   10.353028][    T1] x23: ffffffeff37e9868 x22: ffffffeff37e9010
x21: ffffff80801e0f80
[   10.360917][    T1] x20: ffffff80801e0f80 x19: fffffffffffffffe
x18: 0000000000000000
[   10.368805][    T1] x17: 000000007e8e0531 x16: 00000000c8a98b59
x15: 00000000000009c4
[   10.376694][    T1] x14: 0000000000000000 x13: 323a30303a303130
x12: 323a373132303a30
[   10.384582][    T1] x11: 0000000000004987 x10: ffffffc00805b2d8 x9
: 0000000000011147
[   10.392471][    T1] x8 : ffffff8089cecc40 x7 : 0000000000000000 x6
: 0000000000000003
[   10.400358][    T1] x5 : 0000000000001e44 x4 : 0000000000000000 x3
: ffffffeff938b2c8
[   10.408246][    T1] x2 : 0000000000000000 x1 : 0000000000000007 x0
: fffffffffffffffe
[   10.416135][    T1] Call trace:
[   10.419304][    T1]  reset_control_reset+0xfc/0x138
[   10.424225][    T1]  qcom_swrm_init+0x44/0x190 [soundwire_qcom]
[   10.430192][    T1]  qcom_swrm_probe+0x31c/0x620 [soundwire_qcom]
[   10.436332][    T1]  platform_probe+0x68/0xd8
[   10.440734][    T1]  really_probe+0xbc/0x2a8
[   10.445040][    T1]  __driver_probe_device+0x78/0xe0
[   10.450044][    T1]  driver_probe_device+0x3c/0xf0
[   10.454876][    T1]  __device_attach_driver+0x90/0xe0
[   10.459968][    T1]  bus_for_each_drv+0x78/0xd0
[   10.464544][    T1]  __device_attach+0xfc/0x190
[   10.469115][    T1]  device_initial_probe+0x14/0x20
[   10.474033][    T1]  bus_probe_device+0x9c/0xa8
[   10.478608][    T1]  device_add+0x390/0x838
[   10.482827][    T1]  platform_device_add+0x100/0x238
[   10.487831][    T1]  mfd_add_devices+0x2b4/0x5c0
[   10.492495][    T1]  wcd934x_slim_status+0x1e8/0x254 [wcd934x]
[   10.498377][    T1]  slim_device_alloc_laddr+0xc4/0x140 [slimbus]
[   10.504533][    T1]  slim_device_probe+0x7c/0x98 [slimbus]
[   10.510072][    T1]  really_probe+0xbc/0x2a8
[   10.514374][    T1]  __driver_probe_device+0x78/0xe0
[   10.519378][    T1]  driver_probe_device+0x3c/0xf0
[   10.524208][    T1]  __driver_attach+0x70/0x120
[   10.528779][    T1]  bus_for_each_dev+0x70/0xc8
[   10.533344][    T1]  driver_attach+0x24/0x30
[   10.537648][    T1]  bus_add_driver+0x154/0x208
[   10.542224][    T1]  driver_register+0x64/0x120
[   10.546797][    T1]  __slim_driver_register+0x34/0x50 [slimbus]
[   10.552766][    T1]  wcd934x_slim_driver_init+0x24/0x1000 [wcd934x]
[   10.559082][    T1]  do_one_initcall+0x48/0x298
[   10.563658][    T1]  do_init_module+0x48/0x1d0
[   10.568139][    T1]  load_module+0x196c/0x1db0
[   10.572616][    T1]  __do_sys_finit_module+0xbc/0x110
[   10.577709][    T1]  __arm64_sys_finit_module+0x20/0x30
[   10.582974][    T1]  invoke_syscall+0x44/0x108
[   10.587456][    T1]  el0_svc_common.constprop.0+0x44/0xf0
[   10.592904][    T1]  do_el0_svc+0x2c/0xb8
[   10.596950][    T1]  el0_svc+0x2c/0xb8
[   10.600737][    T1]  el0t_64_sync_handler+0xb8/0xc0
[   10.605654][    T1]  el0t_64_sync+0x19c/0x1a0
[   10.610044][    T1] ---[ end trace 0000000000000000 ]---
[   10.617577][  T234] qcom-soundwire wcd934x-soundwire.4.auto:
qcom_swrm_irq_handler: SWR new slave attached
[   10.628661][  T234] Unexpected kernel BRK exception at EL1
[   10.634200][  T234] Internal error: BRK handler: f20003e8 [#1] PREEMPT SMP
[   10.641128][  T234] Modules linked in: wcd934x(+) videocc_sm8250
videocc_sdm845 ves1x93 ves1820 venus_enc venus_dec
videobuf2_dma_contig venus_core v4l2_mem2mem ufs_qcom tuner_simple
tuner_types tua9001 tua6100 ts2020 tea5767 tea5761 tda9887 tda8290
tda827x tda826x tda8261 tda8083 tda665x tda18271c2dd tda18271 tda18250
tda18218 tda18212 tda10086 tda10071 tda1004x tda10048 tda10023
tda10021 tc90522 syscon_reboot_mode stv6111 stv6110x stv6110 stv0910
stv090x stv0900 stv0367 stv0299 stv0297 stv0288 stb6100 stb6000
stb0899 spmi_pmic_arb spm spi_qup spi_qcom_qspi spi_pl022
spi_geni_qcom sp887x sp2 soundwire_qcom socinfo snd_soc_wsa881x
snd_soc_wcd934x snd_soc_wcd9335 snd_soc_wcd_mbhc snd_soc_sm8250
snd_soc_sdm845 snd_soc_rt5663 snd_soc_rl6231 snd_soc_qcom_common
snd_soc_max98927 snd_soc_lpass_wsa_macro snd_soc_lpass_va_macro
snd_soc_lpass_macro_common snd_soc_hdmi_codec snd_soc_dmic smsm smp2p
slim_qcom_ngd_ctrl si21xx si2168 si2165 si2157 sdhci_msm s921 s5h1432
s5h1420 s5h1411
[   10.641302][  T234]  s5h1409
[   10.721103][    T1] qcom-soundwire wcd934x-soundwire.4.auto:
Qualcomm Soundwire controller v1.3.0 Registered
[   10.727979][  T234]  rtl2832_sdr rtl2832 rtl2830 rtc_pm8xxx rpmsg_ns
[   10.730996][    T1] init: Loaded kernel module /lib/modules/wcd934x.ko
[   10.740787][  T234]  rpmsg_char rpmhpd rmtfs_mem reset_qcom_pdc
reset_qcom_aoss
[   10.747318][    T1] init: Loading module /lib/modules/xc2028.ko with args ''
[   10.753773][  T234]  regmap_slimbus slimbus regmap_sdw
soundwire_bus r820t qt1010 qrtr_tun qrtr_smd qrtr_mhi qrtr qnoc_sm8250
qnoc_sdm845 qm1d1c0042 qm1d1b0004 qcom_usb_vbus_regulator qcom_tsens
qcom_spmi_regulator qcom_rpm qcom_q6v5_wcss qcom_q6v5_pas
qcom_q6v5_mss qcom_q6v5_adsp qcom_q6v5 qcom_sysmon qcom_pil_info
qcom_hwspinlock qcom_glink_rpm qcom_aoss qcom_wdt qcom_spmi_temp_alarm
qcom_spmi_pmic regmap_spmi qcom_spmi_adc5 qcom_spmi_adc_tm5
qcom_vadc_common qcom_rpmh_regulator qcom_pon reboot_mode
qcom_pmic_typec qcom_pdc qcom_ipcc qcom_cpufreq_hw
qcom_apcs_ipc_mailbox q6prm_clocks q6prm q6asm_dai q6routing q6asm
q6apm_lpass_dais q6apm_dai snd_q6apm q6afe_dai q6afe_clocks q6adm
snd_q6dsp_common q6afe q6core pm8941_pwrkey pm8916_wdt
pinctrl_spmi_mpp pinctrl_spmi_gpio pinctrl_sm8250
pinctrl_sm8250_lpass_lpi pinctrl_sdm845 pinctrl_msm pinctrl_lpass_lpi
phy_qcom_usb_hs ulpi phy_qcom_snps_femto_v2 phy_qcom_qusb2
phy_qcom_qmp_usb phy_qcom_qmp_ufs phy_qcom_qmp_pcie
[   10.768358][  T234]  phy_qcom_qmp_pcie_msm8996 phy_qcom_qmp_combo
or51211 or51132 ohci_platform ohci_pci ohci_hcd nxt6000 nxt200x
nvmem_qfprom mxl692 mxl5xx mxl5007t mxl5005s mxl301rf mt352 mt312
mt2266 mt2131 mt20xx mt2063 mt2060 msm_serial msm msi001 mn88473
mn88472 mn88443x michael_mic mdt_loader mcp251xfd mc44s803 mb86a20s
mb86a16 max2165 m88rs6000t m88rs2000 m88ds3103 lpass_gfm_sm8250
lontium_lt9611uxc lontium_lt9611 lnbp22 lnbp21 lnbh29 lnbh25 lmh
llcc_qcom lgs8gxx lgs8gl5 lgdt330x lgdt3306a lgdt3305 lg2160 l64781
ix2505v itd1000 it913x isl6423 isl6421 isl6405 icc_rpmh icc_osm_l3
icc_bcm_voter i2c_rk3x i2c_qup i2c_qcom_geni i2c_mux_pca954x i2c_dev
i2c_designware_platform i2c_designware_core horus3a helene
gpucc_sm8250 gpucc_sdm845 gpu_sched gpio_wcd934x gpio_regulator
gcc_sm8250 gcc_sdm845 fc2580 fc0013 fc0012 fc0011 fastrpc
extcon_usb_gpio ec100 e4000 dvb_pll ds3000 drxk drxd drx39xyj
drm_dp_aux_bus drm_display_helper display_connector drm_kms_helper
dispcc_sm8250
[   10.854247][  T234]  dispcc_sdm845 dib9000 dib8000 dib7000p
dib7000m dib3000mc dibx000_common dib3000mb dib0090 dib0070 cxd2880
cxd2880_spi cxd2841er cxd2820r cxd2099 cx24123 cx24120 cx24117 cx24116
cx24113 cx24110 cx22702 cx22700 cqhci cpr clk_spmi_pmic_div clk_rpmh
qcom_rpmh cmd_db clk_qcom bcm3510 bam_dma virt_dma ax88179_178a
au8522_dig au8522_decoder au8522_common ath11k_pci mhi ath11k_ahb
ath11k ath10k_snoc qcom_common qcom_glink_smem qcom_glink qcom_smd
smem ath10k_pci ath10k_core ath atbm8830 ascot2e arm_smmu qcom_scm apr
pdr_interface qmi_helpers rpmsg_core af9033 af9013 i2c_mux a8293
[   10.993742][  T234] CPU: 0 PID: 234 Comm: irq/178-wcd934x Tainted:
G        W          5.19.0-mainline-14184-g69dac8e431af #1
[   11.005126][  T234] Hardware name: Thundercomm Dragonboard 845c (DT)
[   11.011531][  T234] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
[   11.019245][  T234] pc : qcom_swrm_irq_handler+0x5d8/0x7a8 [soundwire_qcom]
[   11.026265][  T234] lr : qcom_swrm_irq_handler+0x448/0x7a8 [soundwire_qcom]
[   11.033281][  T234] sp : ffffffc009e73c40
[   11.037319][  T234] x29: ffffffc009e73c40 x28: 000000000000000b
x27: ffffff8088144bb8
[   11.045211][  T234] x26: ffffff8088144898 x25: ffffff8088144880
x24: ffffff8088147800
[   11.053101][  T234] x23: ffffff8088141800 x22: 0000000000000002
x21: 000000000000058c
[   11.060993][  T234] x20: 000000000000000b x19: 0000000000000001
x18: 0000000000000000
[   11.068886][  T234] x17: 000000000005000c x16: 0000000000000000
x15: 0000000000000001
[   11.076778][  T234] x14: 0000000000000001 x13: 0000000000000001
x12: 0000000000000000
[   11.084669][  T234] x11: 0000000000000000 x10: 0000000000000b00 x9
: ffffffc009e737d0
[   11.092560][  T234] x8 : ffffff8088cb58e0 x7 : ffffff80fd69b400 x6
: 0000000005c94c5d
[   11.100450][  T234] x5 : 0002000000200000 x4 : ffffff8088cb4d80 x3
: ffffff80881448b0
[   11.108340][  T234] x2 : 0000000000000000 x1 : 0000000000000000 x0
: 000000000000000b
[   11.116229][  T234] Call trace:
[   11.119402][  T234]  qcom_swrm_irq_handler+0x5d8/0x7a8 [soundwire_qcom]
[   11.126066][  T234]  handle_nested_irq+0xb8/0x138
[   11.130815][  T234]  regmap_irq_thread+0x244/0x698
[   11.135645][  T234]  irq_thread_fn+0x2c/0x98
[   11.139952][  T234]  irq_thread+0x17c/0x228
[   11.144172][  T234]  kthread+0x110/0x120
[   11.148129][  T234]  ret_from_fork+0x10/0x20
[   11.152441][  T234] Code: 34ffd400 aa1303e0 950cd906 17fffe9d (d4207d00)
[   11.159282][  T234] ---[ end trace 0000000000000000 ]---
[   11.164632][  T234] Kernel panic - not syncing: BRK handler: Fatal exception
[   11.171730][  T234] SMP: stopping secondary CPUs
[   11.376443][  T234] Kernel Offset: 0x2fef400000 from 0xffffffc008000000
[   11.383109][  T234] PHYS_OFFSET: 0x80000000
[   11.387322][  T234] CPU features: 0x0000,00041021,19801c86
[   11.392850][  T234] Memory Limit: none


Regards,
Amit Pundir


>
>  drivers/soundwire/bus.c       | 75 ++++++++++++++++++++++++-------------------
>  drivers/soundwire/bus_type.c  | 38 +++++++++++++++-------
>  drivers/soundwire/intel.c     | 18 +++++++++++
>  drivers/soundwire/qcom.c      | 32 +++++++++++++++++-
>  drivers/soundwire/slave.c     |  3 +-
>  drivers/soundwire/stream.c    | 53 +++++++++++++++++++-----------
>  include/linux/soundwire/sdw.h |  8 ++---
>  7 files changed, 157 insertions(+), 70 deletions(-)
>
> --
> ~Vinod
