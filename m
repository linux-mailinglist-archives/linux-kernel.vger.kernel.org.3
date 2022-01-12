Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA5248C54B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiALN4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:56:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53094 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353815AbiALN4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:56:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BBF8B81ECF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 13:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84088C36AE5;
        Wed, 12 Jan 2022 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641995758;
        bh=LCyAi6YgsiSDXDtPDWjyqWCAq5g9M5BXQ4fen5qXzLs=;
        h=Date:From:To:Cc:Subject:From;
        b=oatVOunq/rtBJnHXCsZSpHu7pgJR5klp9MScxupfPKLzL2rt0GEMVVk6uhatXs2vw
         l6P1+cJDsoy0sZ/Betn0jVaCxMnTDjzd4EEFE9z4hJBF+hG0kR9prB4alLR9YVCugo
         3iCJ1Xhc4qRtRPRotDkRxKxzlKhV9eliXpMRvIeI=
Date:   Wed, 12 Jan 2022 14:55:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver changes for 5.17-rc1
Message-ID: <Yd7d6/W1fYi0QGSF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.17-rc1

for you to fetch changes up to fa783154524a71ab74e293cd8251155e5971952b:

  staging: r8188eu: rename camelcase variable uintPeerChannel (2022-01-06 15:15:04 +0100)

----------------------------------------------------------------
Staging drivers update for 5.17-rc1

Here's the big set of staging driver updates for 5.17-rc1

Nothing major in here at all, just lots and lots of tiny cleanups.
Overall more code was removed than added, which is always nice, but
not a huge change.

Majority of the work happened in the r8188eu driver, that had hundreds
of cleanups happen on it, but almost all other staging drivers had
cleanups as well.  No new functionality was added, cleanups only.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abdun Nihaal (2):
      staging: r8188eu: Fix coding style error
      staging: r8188eu: include variable declarations from Hal8188EPwrSeq.h

Alberto Merciai (5):
      staging: vt6655: rename variable bHWRadioOff
      staging: vt6655: refactor camelcase byMaxPwrLevel to max_pwr_level
      staging: vt6655: refactor camelcase uCurrRSSI to current_rssi
      staging: r8188eu: add spaces around P2P_AP_P2P_CH_SWITCH_PROCESS_WK
      staging: r8188eu: rename camelcase variable uintPeerChannel

Arnd Bergmann (1):
      staging: greybus: fix stack size warning with UBSAN

Candy Febriyanto (1):
      staging: r8188eu: Remove support for devices with 8188FU chipset (0bda:f179)

Colin Ian King (1):
      staging: rtl8192u: make array queuetopipe static const

Gabriel Goller (1):
      staging: wlan-ng: Removed unused comments

Gaston Gonzalez (9):
      staging: vchiq_core: remove superfluous static_assert statement
      staging: vc04_services: bcm2835-audio: avoid the use of typedef for function pointers
      staging: vc04_services: bcm2835-camera: avoid the use of typedef for function pointers
      staging: vc04_services: update TODO file
      staging: vc04_services: rename structures bm2835_mmal_dev and bm2835_mmal_v4l2_ctrl
      staging: vc04_services: rename functions containing bm2835_* to bcm2835_*
      staging: vc04_services: rename variables containing bm2835_* to bcm2835_*
      staging: vc04_services: rename string literal containing bm2835_* to bcm2835*_
      staging: vc04_services: rename BM2835 to BCM2835 in headers comments

Gautam Menghani (1):
      staging: vc04_services: Remove repeated word in vchiq log warning

Greg Kroah-Hartman (2):
      Merge 5.16-rc3 into staging-next
      staging: greybus: auto_manager: use default_groups in kobj_type

Guo Zhengkui (1):
      staging: r8188eu: fix array_size.cocci warning

Heiner Kallweit (2):
      staging: fbtft: add macro FBTFT_REGISTER_SPI_DRIVER
      staging: fbtft: sh1106: use new macro FBTFT_REGISTER_SPI_DRIVER

Ismayil Mirzali (1):
      staging: rtl8723bs: removed unused if blocks

Jason Wang (2):
      staging: rtl8192u: remove some repeated words in some comments
      staging: rtl8723bs: fix typo in a comment

Jiasheng Jiang (1):
      staging: greybus: audio: Check null pointer

Karolina Drobnik (8):
      staging: vt6655: Remove unnecessary type casts
      staging: vt6655: Introduce `idx` variable
      staging: vt6655: Use incrementation in `idx`
      staging: vt6655: Rewrite conditional in AL7320 initialization
      staging: vt6655: Rename `RFvWriteWakeProgSyn` function
      staging: vt6655: Update comment for `rf_write_wake_prog_syn`
      staging: vt6655: Delete bogus check for `init_count` in AL2230
      staging: vt6655: Delete bogus check for `init_count` in AL7230

Lad Prabhakar (1):
      staging: axis-fifo: Use platform_get_irq() to get the interrupt

Liu Junqi (4):
      staging: unisys: visorhba: use tab to indent instead of whitespace
      staging: unisys: visornic: fixed a typo cant -> can't
      staging: unisys: visornic: reindent to avoid '(' at the end of line
      staging: unisys: visornic: removed a blank line at the end of function

Martin Kaiser (132):
      staging: r8188eu: remove ODM_Read1Byte
      staging: r8188eu: remove ODM_Read4Byte
      staging: r8188eu: remove ODM_Write1Byte
      staging: r8188eu: remove ODM_Write2Byte
      staging: r8188eu: remove ODM_Write4Byte
      staging: r8188eu: remove unused phy_PathA_IQK_8188E parameter
      staging: r8188eu: remove unused phy_PathA_RxIQK parameter
      staging: r8188eu: remove constant phy_IQCalibrate_8188E parameter
      staging: r8188eu: clean up _PHY_PathADDAOn
      staging: r8188eu: remove write support from rtl8188e_EfusePowerSwitch
      staging: r8188eu: remove efuse write functions
      staging: r8188eu: remove haldata's EEPROMVID / PID
      staging: r8188eu: remove haldata's EEPROMCustomerID
      staging: r8188eu: remove haldata's EEPROMSubCustomerID
      staging: r8188eu: remove autoload check
      staging: r8188eu: rf_chip is constant
      staging: r8188eu: merge three small functions
      staging: r8188eu: simplify two boolean assignments
      staging: r8188eu: remove efuse type from definition functions
      staging: r8188eu: remove efuse type from read functions
      staging: r8188eu: remove test code for efuse shadow map
      staging: r8188eu: merge small adapter info helpers
      staging: r8188eu: rtl8188e_EfuseGetCurrentSize is now unused
      staging: r8188eu: rtl8188e_Efuse_PgPacketRead is now unused
      staging: r8188eu: merge Efuse_ReadAllMap into EFUSE_ShadowMapUpdate
      staging: r8188eu: use efuse map length define directly
      staging: r8188eu: rtl8188e_EFUSE_GetEfuseDefinition is unused
      staging: r8188eu: remove defines for efuse type
      staging: r8188eu: efuse_OneByteRead is unused
      staging: r8188eu: efuse_OneByteWrite is unused
      staging: r8188eu: remove bt efuse definitions
      staging: r8188eu: remove fake efuse variables
      staging: r8188eu: remove the efuse_hal structure
      staging: r8188eu: Efuse_CalculateWordCnts is not used
      staging: r8188eu: efuse_WordEnableDataRead is not used
      staging: r8188eu: remove unused efuse defines
      staging: r8188eu: do not extract eeprom version from the fuses
      staging: r8188eu: remove unused eeprom defines
      staging: r8188eu: hal data's board type is unused
      staging: r8188eu: remove the _set_workitem wrapper
      staging: r8188eu: remove the _init_workitem wrapper
      staging: r8188eu: remove the _cancel_workitem_sync wrapper
      staging: r8188eu: rtw_read_port needs no cnt parameter
      staging: r8188eu: only the bulk in ep is used for network data
      staging: r8188eu: get the rcv bulk pipe handle directly
      staging: r8188eu: remove code to get int in pipe handle
      staging: r8188eu: if2 is not used
      staging: r8188eu: remove ep_num array
      staging: r8188eu: don't store nr_endpoint in a global struct
      staging: r8188eu: require a single bulk in endpoint
      staging: r8188eu: remove pm_netdev_open
      staging: r8188eu: remove _ps_open_RF
      staging: r8188eu: remove _ps_close_RF
      staging: r8188eu: loadparam needs no net_device
      staging: r8188eu: use a delayed worker for led updates
      staging: r8188eu: bLedOpenDrain is always true for r8188eu
      staging: r8188eu: remove a bunch of unused led defines
      staging: r8188eu: remove two unused macros
      staging: r8188eu: bHWPowerdown is set but not used
      staging: r8188eu: remove unused macros from drv_types.h
      staging: r8188eu: hal data's interfaceIndex is never read
      staging: r8188eu: remove empty HAL_INIT_PROFILE_TAG macro
      staging: r8188eu: remove two write-only wifi direct variables
      staging: r8188eu: remove unused define
      staging: r8188eu: AntCombination is always 2
      staging: r8188eu: remove SwLed1
      staging: r8188eu: remove code to set led1 registers
      staging: r8188eu: remove LedPin from struct struct LED_871x
      staging: r8188eu: move xmit status check from hal to rtw_cmd
      staging: r8188eu: move linked status check from hal to rtw_mlme_ext
      staging: r8188eu: clean up rtl8188e_sreset_linked_status_check
      staging: r8188: make rx signal strength function static
      staging: r8188: remove the dummy ioctl handler
      staging: r8188: antAveRSSI is set but not used
      staging: r8188: antRSSIcnt is set but not used
      staging: r8188: antSumRSSI is set but not used
      staging: r8188: Bssid in struct fast_ant_train is set but not used
      staging: r8188: remove unused odm capabilities
      staging: r8188: ODM_BB_DIG is always set
      staging: r8188: ODM_BB_RA_MASK is always set
      staging: r8188: remove unused power transitions
      staging: r8188: remove sizes from power transition arrays
      staging: r8188: remove cut mask from power transitions
      staging: r8188: remove fab mask from power transitions
      staging: r8188: remove interface mask from power transitions
      staging: r8188: remove base address from power transitions
      staging: r8188: remove unused power command
      staging: r8188: reformat the power transition steps
      staging: r8188: move the steps into Hal8188EPwrSeq.c
      staging: r8188eu: switch the led off during deinit
      staging: r8188eu: move SwLedOn and SwLedOff into rtw_led.c
      staging: r8188eu: move (de)init functions from hal to rtw_led
      staging: r8188eu: merge InitLed871x and rtl8188eu_InitSwLeds
      staging: r8188eu: merge DeInitLed871x and rtl8188eu_DeInitSwLeds
      staging: r8188eu: make ResetLedStatus static
      staging: r8188eu: clean up the blink worker code
      staging: r8188eu: clean up blinking macros
      staging: r8188eu: remove unused blink mode defines
      staging: r8188eu: bLedStartToLinkBlinkInProgress is set but not used
      staging: r8188eu: make blink interval defines internal
      staging: r8188eu: use bool for boolean values
      staging: r8188eu: remove obsolete comments
      staging: r8188eu: remove LedControlHandler
      staging: r8188eu: LED_CTL_POWER_ON is not used
      staging: r8188eu: LED_CTL_START_WPS_BOTTON is not used
      staging: r8188eu: remove bStopBlinking
      staging: r8188eu: summarize some BlinkingLedState
      staging: r8188eu: merge blink_work and SwLedBlink1
      staging: r8188eu: merge rtw_led_control and SwLedControlMode1
      staging: r8188eu: rfoff_reason is never initialised
      staging: r8188eu: remove unused rtw_private_args entries
      staging: r8188eu: remove the private ioctl "get sensitivity"
      staging: r8188eu: remove the private drvext_hdl ioctl
      staging: r8188eu: remove the private ioctl "wps_prob_req_ie"
      staging: r8188eu: remove private ioctls that return -1
      staging: r8188eu: remove the private ioctl "wps_assoc_req_ie"
      staging: r8188eu: remove the private ioctl "tdls_get"
      staging: r8188eu: remove the private ioctl "tdls"
      staging: r8188eu: remove the private "test" ioctl
      staging: r8188eu: remove unused prototype
      staging: r8188eu: remove unused power management defines
      staging: r8188eu: internal autosuspend is always false
      staging: r8188eu: fix_rate is set but not used.
      staging: r8188eu: cmd_issued_cnt is set but not used
      staging: r8188eu: turbo scan is always off for r8188eu
      staging: r8188eu: rfPath is always 0
      staging: r8188eu: make Index24G_CCK_Base a 1-D array
      staging: r8188eu: make Index24G_BW40_Base a 1-D array
      staging: r8188eu: CCK_24G_Diff is set but not used
      staging: r8188eu: BW40_24G_Diff is set but not used
      staging: r8188eu: make OFDM_24G_Diff a 1-D array
      staging: r8188eu: make BW20_24G_Diff a 1-D array

Michael Straube (92):
      staging: r8188eu: code indent should use tabs
      staging: r8188eu: remove rf_type from rtw_mcs_rate()
      staging: r8188eu: remove rf_type from add_RATid()
      staging: r8188eu: remove rf_type from HT_caps_handler()
      staging: r8188eu: remove rf_type from rtw_update_ht_cap()
      staging: r8188eu: remove rf_type from issue_assocreq()
      staging: r8188eu: remove rf_type from storePwrIndexDiffRateOffset()
      staging: r8188eu: remove rf_type from getTxPowerIndex88E()
      staging: r8188eu: remove TxCount from getTxPowerIndex88E()
      staging: r8188eu: remove rf_type from writeOFDMPowerReg88E()
      staging: r8188eu: remove rf_type from bb_reg_dump()
      staging: r8188eu: remove unused HW_VAR_RF_TYPE
      staging: r8188eu: remove rf_type from struct hal_data_8188e
      staging: r8188eu: remove module parameter rtw_rf_config
      staging: r8188eu: RFType is set but never used
      staging: r8188eu: remove unused variables from odm_dm_struct
      staging: r8188eu: pbNet_closed is set but never used
      staging: r8188eu: pSecurity is set but never used
      staging: r8188eu: pNumTxBytesUnicast is set but never used
      staging: r8188eu: pNumRxBytesUnicast is set but never used
      staging: r8188eu: remove RF_PATH_{C,D}
      staging: r8188eu: struct odm_mac_status_info is not used
      staging: r8188eu: remove macro PHY_SetRFReg
      staging: r8188eu: remove macro PHY_QueryRFReg
      staging: r8188eu: remove macro PHY_SetBBReg
      staging: r8188eu: remove macro PHY_QueryBBReg
      staging: r8188eu: remove duplicate defines
      staging: r8188eu: bWIFI_Direct is set but never used
      staging: r8188eu: bWIFI_Display is set but never used
      staging: r8188eu: remove unused macro IS_FW_81xxC
      staging: r8188eu: convert type of HalData in struct adapter
      staging: r8188eu: DM_PriCCA is set but never used
      staging: r8188eu: remove GET_CVID_ROM_VERSION
      staging: r8188eu: remove unused enum odm_h2c_cmd
      staging: r8188eu: remove ODM_CMNINFO_ABILITY from ODM_CmnInfoInit()
      staging: r8188eu: remove write-only fields from struct rtl_ps
      staging: r8188eu: FAT_State is always FAT_NORMAL_STATE
      staging: r8188eu: FAT_State is set but never used
      staging: r8188eu: TrainIdx is set but never used
      staging: r8188eu: RSSI_test is always false
      staging: r8188eu: merge _ReadLEDSetting() into ReadAdapterInfo8188EU()
      staging: r8188eu: remove ODM_SetMACReg()
      staging: r8188eu: remove ODM_GetMACReg()
      staging: r8188eu: remove ODM_GetRFReg()
      staging: r8188eu: remove ODM_SetRFReg()
      staging: r8188eu: remove ODM_GetBBReg()
      staging: r8188eu: remove ODM_SetBBReg()
      staging: r8188eu: clean up coding style issues
      staging: r8188eu: remove ODM_sleep_ms()
      staging: r8188eu: remove ODM_delay_us()
      staging: r8188eu: remove ODM_delay_ms()
      staging: r8188eu: remove ODM_CompareMemory()
      staging: r8188eu: remove odm_interface
      staging: r8188eu: make odm_ConfigRFReg_8188E() static
      staging: r8188eu: remove unused prototypes
      staging: r8188eu: make odm_DIGInit() static
      staging: r8188eu: make odm_DIG() static
      staging: r8188eu: make odm_CommonInfoSelfInit() static
      staging: r8188eu: make odm_CommonInfoSelfUpdate() static
      staging: r8188eu: make odm_RateAdaptiveMaskInit() static
      staging: r8188eu: make odm_RefreshRateAdaptiveMask() static
      staging: r8188eu: make odm_DynamicBBPowerSavingInit() static
      staging: r8188eu: make odm_FalseAlarmCounterStatistics() static
      staging: r8188eu: make odm_CCKPacketDetectionThresh() static
      staging: r8188eu: make odm_RSSIMonitorCheck() static
      staging: r8188eu: remove odm_TXPowerTrackingInit()
      staging: r8188eu: make odm_TXPowerTrackingThermalMeterInit() static
      staging: r8188eu: make odm_InitHybridAntDiv() static
      staging: r8188eu: make odm_HwAntDiv() static
      staging: r8188eu: make ODM_EdcaTurboInit() static
      staging: r8188eu: make odm_EdcaTurboCheck() static
      staging: r8188eu: remove unnecessary comments
      staging: r8188eu: remove header odm_precomp.h
      staging: r8188eu: bRDGEnable is always false
      staging: r8188eu: UsbRxHighSpeedMode is set but never used
      staging: r8188eu: bTXPowerDataReadFromEEPORM is set but never used
      staging: r8188eu: bAPKThermalMeterIgnore is set but never used
      staging: r8188eu: remove unused fields from struct hal_data_8188e
      staging: r8188eu: IntArray and C2hArray are set but never used
      staging: r8188eu: FwRsvdPageStartOffset is set but never used
      staging: r8188eu: remove MAX_CHANNEL_NUM_2G
      staging: r8188eu: remove struct rt_channel_plan_2g
      staging: r8188eu: remove unused enum and defines
      staging: r8188eu: struct rx_hpc is not used
      staging: r8188eu: clean up struct rtw_dig
      staging: r8188eu: clean up struct sw_ant_switch
      staging: r8188eu: struct odm_sta_info is not used
      staging: r8188eu: enum hw90_block is not used
      staging: r8188eu: remove unneeded comments from Hal8188EPhyCfg.h
      staging: r8188eu: remove unused defines from Hal8188EPhyCfg.h
      staging: r8188eu: remove unused defines from rtw_eeprom.h
      staging: r8188eu: remove unneeded parameter from rtl8188e_SetHalODMVar

Ngo Tak Fong (1):
      staging: rtl8712: Fix alignment checks with flipped condition

Nikita Yushchenko (2):
      staging: most: dim2: update renesas compatible string
      staging: most: dim2: use consistent routine naming

Noralf Trønnes (1):
      staging: fbtft: Remove fb_watterott driver

Paulo Miguel Almeida (4):
      staging: pi433: remove unnecessary parentheses pointed out by checkpatch.pl
      staging: pi433: add docs to packet_format and tx_start_condition enum
      staging: pi433: fix frequency deviation check
      staging: pi433: add comment to rx_lock mutex definition

Phillip Potter (12):
      staging: r8188eu: remove MSG_88E call from odm_TXPowerTrackingThermalMeterInit
      staging: r8188eu: convert final two MSG_88E calls to netdev_dbg
      staging: r8188eu: remove MSG_88E macro
      staging: r8188eu: convert DBG_88E_LEVEL calls in core/rtw_mlme_ext.c
      staging: r8188eu: convert DBG_88E_LEVEL calls in core/rtw_pwrctrl.c
      staging: r8188eu: convert DBG_88E_LEVEL call in core/rtw_xmit.c
      staging: r8188eu: convert DBG_88E_LEVEL calls in core/rtw_ioctl_set.c
      staging: r8188eu: convert DBG_88E_LEVEL call in hal/rtl8188e_hal_init.c
      staging: r8188eu: convert DBG_88E_LEVEL calls in os_dep/ioctl_linux.c
      staging: r8188eu: remove DBG_88E_LEVEL macro from include/rtw_debug.h
      staging: r8188eu: convert DBG_88E calls in core/rtw_security.c
      staging: r8188eu: convert/remove DBG_88E calls in core/rtw_cmd.c

Saurav Girepunje (9):
      staging: r8188eu: os_dep: remove the goto statement
      staging: r8188eu: core: remove the function __nat25_timeout
      staging: r8188eu: core: remove unused variable sz
      staging: r8188eu: core: remove the unused variable pAdapter
      staging: rtl8723bs: core: remove unused variable pAdapter
      staging: rtl8723bs: core: remove unused local variable padapter
      staging: r8188eu: os_dep: Change the return type of function
      staging: rtl8723bs: core: avoid unnecessary if condition
      staging: rtl8192u: remove the if condition without effect

Sergio Paracuellos (3):
      staging: ralink-gdma: remove driver from tree
      staging: mt7621-dma: remove driver from tree
      staging: mt7621-dts: remove 'gdma' and 'hsdma' nodes

Sidong Yang (1):
      staging: pi433: print rf69 debug message more detail

Tommaso Merciai (3):
      staging: vt6655: fix camelcase byData in card.c
      staging: vt6655: fix camelcase in bRadioOff
      staging: vt6655: drop off byRxMode var in device.h

Vihas Mak (1):
      staging: r8188eu: use max() and min() macros

Yang Yingliang (3):
      staging: rtl8192e: return error code from rtllib_softmac_init()
      staging: rtl8192e: rtllib_module: fix error handle case in alloc_rtllib()
      staging: rtl8192e: rtllib_module: remove unnecessary assignment

Zameer Manji (2):
      staging: r8188eu: remove unused defines in wifi.h
      staging: r8188eu: delete unused header

 drivers/staging/Kconfig                            |    4 -
 drivers/staging/Makefile                           |    2 -
 drivers/staging/axis-fifo/axis-fifo.c              |   11 +-
 drivers/staging/fbtft/Kconfig                      |    6 -
 drivers/staging/fbtft/Makefile                     |    1 -
 drivers/staging/fbtft/fb_sh1106.c                  |    7 +-
 drivers/staging/fbtft/fb_watterott.c               |  302 ------
 drivers/staging/fbtft/fbtft.h                      |   41 +
 drivers/staging/greybus/audio_manager_module.c     |    3 +-
 drivers/staging/greybus/audio_topology.c           |  107 ++-
 drivers/staging/most/dim2/dim2.c                   |   28 +-
 drivers/staging/mt7621-dma/Kconfig                 |    7 -
 drivers/staging/mt7621-dma/Makefile                |    4 -
 drivers/staging/mt7621-dma/TODO                    |    5 -
 drivers/staging/mt7621-dma/hsdma-mt7621.c          |  758 ---------------
 drivers/staging/mt7621-dts/mt7621.dtsi             |   38 -
 drivers/staging/pi433/pi433_if.c                   |    2 +-
 drivers/staging/pi433/rf69.c                       |   62 +-
 drivers/staging/pi433/rf69_enum.h                  |   12 +
 drivers/staging/r8188eu/Makefile                   |    3 -
 drivers/staging/r8188eu/core/rtw_ap.c              |   11 +-
 drivers/staging/r8188eu/core/rtw_br_ext.c          |   11 +-
 drivers/staging/r8188eu/core/rtw_cmd.c             |   36 +-
 drivers/staging/r8188eu/core/rtw_efuse.c           |  221 +----
 drivers/staging/r8188eu/core/rtw_ieee80211.c       |   73 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c       |   19 +-
 drivers/staging/r8188eu/core/rtw_led.c             |  285 +++---
 drivers/staging/r8188eu/core/rtw_mlme.c            |   16 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c        |  102 +-
 drivers/staging/r8188eu/core/rtw_p2p.c             |    6 -
 drivers/staging/r8188eu/core/rtw_pwrctrl.c         |   22 +-
 drivers/staging/r8188eu/core/rtw_rf.c              |    2 +-
 drivers/staging/r8188eu/core/rtw_security.c        |   22 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c         |    2 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c       |   23 +-
 drivers/staging/r8188eu/core/rtw_xmit.c            |    2 +-
 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c       |  100 +-
 drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c |   27 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c     |    1 -
 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c    |    1 -
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c     |    1 -
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c       |  401 +++-----
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c         |   84 +-
 drivers/staging/r8188eu/hal/odm.c                  |  937 ++++++++----------
 drivers/staging/r8188eu/hal/odm_HWConfig.c         |   20 +-
 drivers/staging/r8188eu/hal/odm_RTL8188E.c         |  176 ++--
 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c   |   60 +-
 drivers/staging/r8188eu/hal/odm_debug.c            |    2 +-
 drivers/staging/r8188eu/hal/odm_interface.c        |   93 --
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c         |   13 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c          |   25 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c    | 1010 ++------------------
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c      |  197 +---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c      |   65 +-
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c      |    2 +-
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c      |   37 -
 drivers/staging/r8188eu/hal/rtl8188eu_led.c        |   94 --
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c       |    4 +-
 drivers/staging/r8188eu/hal/usb_halinit.c          |  263 ++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c        |   32 +-
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h   |   60 +-
 drivers/staging/r8188eu/include/Hal8188EPwrSeq.h   |  148 +--
 drivers/staging/r8188eu/include/HalPhyRf_8188e.h   |    5 -
 drivers/staging/r8188eu/include/HalPwrSeqCmd.h     |   53 +-
 drivers/staging/r8188eu/include/HalVerDef.h        |   13 -
 drivers/staging/r8188eu/include/drv_types.h        |   19 +-
 drivers/staging/r8188eu/include/hal_intf.h         |   30 +-
 drivers/staging/r8188eu/include/ieee80211.h        |    3 +-
 drivers/staging/r8188eu/include/ieee80211_ext.h    |  271 ------
 drivers/staging/r8188eu/include/odm.h              |  216 +----
 drivers/staging/r8188eu/include/odm_RTL8188E.h     |    6 -
 .../staging/r8188eu/include/odm_RegConfig8188E.h   |    3 -
 drivers/staging/r8188eu/include/odm_interface.h    |   59 --
 drivers/staging/r8188eu/include/odm_precomp.h      |   54 --
 drivers/staging/r8188eu/include/osdep_service.h    |   32 -
 drivers/staging/r8188eu/include/rtl8188e_dm.h      |    7 +-
 drivers/staging/r8188eu/include/rtl8188e_hal.h     |  100 +-
 drivers/staging/r8188eu/include/rtl8188e_led.h     |   16 -
 drivers/staging/r8188eu/include/rtl8188e_recv.h    |    3 -
 drivers/staging/r8188eu/include/rtl8188e_spec.h    |   61 --
 drivers/staging/r8188eu/include/rtl8188e_sreset.h  |   13 -
 drivers/staging/r8188eu/include/rtw_cmd.h          |    1 -
 drivers/staging/r8188eu/include/rtw_debug.h        |   12 -
 drivers/staging/r8188eu/include/rtw_eeprom.h       |   31 -
 drivers/staging/r8188eu/include/rtw_efuse.h        |  104 +-
 drivers/staging/r8188eu/include/rtw_io.h           |    2 +-
 drivers/staging/r8188eu/include/rtw_led.h          |  116 +--
 drivers/staging/r8188eu/include/rtw_mlme.h         |   12 -
 drivers/staging/r8188eu/include/rtw_mlme_ext.h     |    5 -
 drivers/staging/r8188eu/include/rtw_pwrctrl.h      |    7 -
 drivers/staging/r8188eu/include/rtw_recv.h         |    1 -
 drivers/staging/r8188eu/include/rtw_rf.h           |   34 -
 drivers/staging/r8188eu/include/usb_osintf.h       |    1 -
 drivers/staging/r8188eu/include/wifi.h             |   59 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c       |  235 +----
 drivers/staging/r8188eu/os_dep/os_intfs.c          |   69 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c          |   42 +-
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c     |    6 +-
 drivers/staging/ralink-gdma/Kconfig                |    8 -
 drivers/staging/ralink-gdma/Makefile               |    4 -
 drivers/staging/ralink-gdma/ralink-gdma.c          |  917 ------------------
 drivers/staging/rtl8192e/rtllib.h                  |    2 +-
 drivers/staging/rtl8192e/rtllib_module.c           |   17 +-
 drivers/staging/rtl8192e/rtllib_softmac.c          |    6 +-
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c |    4 +-
 drivers/staging/rtl8192u/r8192U_core.c             |   13 +-
 drivers/staging/rtl8712/rtl8712_efuse.c            |   28 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |    3 +-
 drivers/staging/rtl8723bs/core/rtw_efuse.c         |   14 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |    5 -
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |    2 +-
 drivers/staging/unisys/visorhba/visorhba_main.c    |    2 +-
 drivers/staging/unisys/visornic/visornic_main.c    |    8 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  |   12 +-
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |   89 +-
 .../vc04_services/bcm2835-camera/bcm2835-camera.h  |   12 +-
 .../vc04_services/bcm2835-camera/controls.c        |  143 ++-
 drivers/staging/vc04_services/interface/TODO       |    8 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |    2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |    2 -
 .../staging/vc04_services/vchiq-mmal/mmal-common.h |    2 +-
 .../vc04_services/vchiq-mmal/mmal-encodings.h      |    2 +-
 .../vc04_services/vchiq-mmal/mmal-msg-common.h     |    2 +-
 .../vc04_services/vchiq-mmal/mmal-msg-format.h     |    2 +-
 .../vc04_services/vchiq-mmal/mmal-msg-port.h       |    2 +-
 .../staging/vc04_services/vchiq-mmal/mmal-msg.h    |    2 +-
 .../vc04_services/vchiq-mmal/mmal-parameters.h     |    2 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |    2 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.h  |    2 +-
 drivers/staging/vt6655/card.c                      |   36 +-
 drivers/staging/vt6655/channel.c                   |    2 +-
 drivers/staging/vt6655/device.h                    |   10 +-
 drivers/staging/vt6655/device_main.c               |   12 +-
 drivers/staging/vt6655/dpc.c                       |    2 +-
 drivers/staging/vt6655/rf.c                        |   54 +-
 drivers/staging/vt6655/rf.h                        |    2 +-
 drivers/staging/wlan-ng/prism2mib.c                |    8 -
 137 files changed, 1760 insertions(+), 7495 deletions(-)
 delete mode 100644 drivers/staging/fbtft/fb_watterott.c
 delete mode 100644 drivers/staging/mt7621-dma/Kconfig
 delete mode 100644 drivers/staging/mt7621-dma/Makefile
 delete mode 100644 drivers/staging/mt7621-dma/TODO
 delete mode 100644 drivers/staging/mt7621-dma/hsdma-mt7621.c
 delete mode 100644 drivers/staging/r8188eu/hal/odm_interface.c
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_sreset.c
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_led.c
 delete mode 100644 drivers/staging/r8188eu/include/ieee80211_ext.h
 delete mode 100644 drivers/staging/r8188eu/include/odm_interface.h
 delete mode 100644 drivers/staging/r8188eu/include/odm_precomp.h
 delete mode 100644 drivers/staging/r8188eu/include/rtl8188e_led.h
 delete mode 100644 drivers/staging/r8188eu/include/rtl8188e_sreset.h
 delete mode 100644 drivers/staging/ralink-gdma/Kconfig
 delete mode 100644 drivers/staging/ralink-gdma/Makefile
 delete mode 100644 drivers/staging/ralink-gdma/ralink-gdma.c
