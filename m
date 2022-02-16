Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896164B9055
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbiBPSf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:35:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237688AbiBPSfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:35:48 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C302ABD0E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:35:35 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21GFG5b9000467;
        Wed, 16 Feb 2022 18:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=pCN+jqEdmctqLRCK7bIitZB8NHdC3107Hp/bvH4s9Sc=;
 b=OXHPIGRY8xCRx2V/0O0vVl/VX7AksB75Nai2Cg89ea10DDRx6ifFwAjkhSOwRbgp5oWR
 teYy/Qsj/0iTBPke3kk6rCKPwacWsESUNPATqj7WtWEhWAESs7vypGo/uzdHYTaUEPE/
 OxEfjGsOLRhtWAgNVCcHQZ7myqa+8KCBgKZJr/JYPj1IZ5LsAmqgZCZGAFej+y4XX6BL
 188qojOr6eANWh9FP+54hASoqRXarnSsUrFQ6Zzm7y6FO1vLUs/BWT/TRQ9bawPOvKFX
 O2BlDXaQvQe3C4gzRFg4+Lj2QWrN1plfgPzlfduYMQ6wHu7eo3iRazrwzxdSNWqQlnDC Ew== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3e8x4yn5bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 18:35:09 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 28F10B9;
        Wed, 16 Feb 2022 18:35:08 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Russell King <linux@armlinux.org.uk>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v1] arch: arm: configs: gxp_defconfig
Date:   Wed, 16 Feb 2022 12:36:59 -0600
Message-Id: <20220216183704.42084-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <nick.hawkins@hpe.com>
References: <nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: 2qRO2cfKgVhlM5dSoiUGOtMhxyel6xLc
X-Proofpoint-GUID: 2qRO2cfKgVhlM5dSoiUGOtMhxyel6xLc
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_08,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 clxscore=1011 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160104
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Description: Adding the configuration file for the upcoming
 hpe gxp soc.

Note: This patch is part of a set with patches:
  [v4] arch: arm: boot: dts: Create HPE GXP Device Tree
  [v1] dt-bindings: timer: Add HPE GXP Timer binding
  [v1] dt-bindings: watchdog: Add HPE GXP Watchdog timer binding
  [v1]dt-bindings: vendor-prefixes: add HPE Prefix
  [v1] dt-bindings: soc: Add HPE GXP SOC binding

Additional Note: Maintainers will be updated in separate patch
 to cover all of the above patches.

Information: GXP is the name of the HPE SoC.
 This SoC is used to implement BMC features of HPE servers
  (all ProLiant, Synergy, and many Apollo, and Superdome machines)
   It does support many features including:
    ARMv7 architecture, and it is based on a Cortex A9 core
    Use an AXI bus to which a memory controller is attached,
    as well as multiple SPI interfaces to connect boot flash,
    and ROM flash, a 10/100/1000 Mac engine which
    supports SGMII (2 ports) and RMII Multiple I2C engines to
    drive connectivity with a host infrastructure
    A video engine which support VGA and DP, as well as
    an hardware video encoder
    Multiple PCIe ports
    A PECI interface, and LPC eSPI
    Multiple UART for debug purpose, and Virtual UART for
    host connectivity
    A GPIO engine.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 arch/arm/configs/gxp_defconfig | 243 +++++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)
 create mode 100644 arch/arm/configs/gxp_defconfig

diff --git a/arch/arm/configs/gxp_defconfig b/arch/arm/configs/gxp_defconfig
new file mode 100644
index 000000000000..f37c6630e06d
--- /dev/null
+++ b/arch/arm/configs/gxp_defconfig
@@ -0,0 +1,243 @@
+CONFIG_KERNEL_XZ=y
+CONFIG_DEFAULT_HOSTNAME="gxp"
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_LOG_BUF_SHIFT=18
+CONFIG_CFS_BANDWIDTH=y
+CONFIG_RT_GROUP_SCHED=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_NAMESPACES=y
+CONFIG_SCHED_AUTOGROUP=y
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+CONFIG_ARCH_MULTI_V6=y
+CONFIG_ARCH_HPE=y
+CONFIG_ARCH_HPE_GXP=y
+CONFIG_SECCOMP=y
+# CONFIG_ATAGS is not set
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+# CONFIG_SUSPEND is not set
+CONFIG_JUMP_LABEL=y
+# CONFIG_STRICT_KERNEL_RWX is not set
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_KSM=y
+CONFIG_CLEANCACHE=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_PACKET_DIAG=y
+CONFIG_UNIX=y
+CONFIG_UNIX_DIAG=y
+CONFIG_XFRM_USER=y
+CONFIG_XFRM_STATISTICS=y
+CONFIG_INET=y
+CONFIG_VLAN_8021Q=y
+CONFIG_NETLINK_DIAG=y
+CONFIG_NET_NCSI=y
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_PLATRAM=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_SPI_GXP_SPIFI=y
+CONFIG_BLK_DEV_NULL_BLK=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_NBD=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_EEPROM_AT24=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ALACRITECH is not set
+# CONFIG_NET_VENDOR_AMAZON is not set
+# CONFIG_NET_VENDOR_AQUANTIA is not set
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_AURORA is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CADENCE is not set
+# CONFIG_NET_VENDOR_CAVIUM is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_CORTINA is not set
+# CONFIG_NET_VENDOR_EZCHIP is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_GOOGLE is not set
+# CONFIG_NET_VENDOR_HISILICON is not set
+# CONFIG_NET_VENDOR_HUAWEI is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MELLANOX is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_MICROSEMI is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NETRONOME is not set
+# CONFIG_NET_VENDOR_NI is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_RENESAS is not set
+# CONFIG_NET_VENDOR_ROCKER is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SOLARFLARE is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_SOCIONEXT is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_SYNOPSYS is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_NET_VENDOR_XILINX is not set
+CONFIG_UMAC=y
+# CONFIG_USB_NET_DRIVERS is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_LEDS is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_GPIO_POLLED=y
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_SERIO_LIBPS2=y
+CONFIG_VT_HW_CONSOLE_BINDING=y
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=6
+CONFIG_SERIAL_8250_RUNTIME_UARTS=6
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_GXP_VUART=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_TTY_PRINTK=y
+CONFIG_IPMI_HANDLER=y
+CONFIG_IPMI_DEVICE_INTERFACE=y
+CONFIG_IPMI_SI=y
+CONFIG_IPMI_SSIF=y
+CONFIG_HPE_KCS_IPMI_BMC=y
+CONFIG_HW_RANDOM_TIMERIOMEM=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_GXP=y
+CONFIG_I2C_SLAVE=y
+CONFIG_I2C_SLAVE_EEPROM=y
+CONFIG_SPI=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_GXP=y
+CONFIG_SENSORS_EMC1403=y
+CONFIG_SENSORS_GXP_FAN_CTRL=y
+CONFIG_SENSORS_GXP_CORETEMP=y
+CONFIG_SENSORS_GXP_PSU=y
+CONFIG_SENSORS_GXP_POWER=y
+CONFIG_WATCHDOG=y
+CONFIG_GXP_WATCHDOG=y
+CONFIG_MFD_SYSCON=y
+CONFIG_FB=y
+CONFIG_FB_THUMBNAIL=y
+CONFIG_FB_SIMPLE=y
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GXP_UDC=y
+CONFIG_USB_CONFIGFS=y
+CONFIG_USB_CONFIGFS_SERIAL=y
+CONFIG_USB_CONFIGFS_ACM=y
+CONFIG_USB_CONFIGFS_OBEX=y
+CONFIG_USB_CONFIGFS_NCM=y
+CONFIG_USB_CONFIGFS_ECM=y
+CONFIG_USB_CONFIGFS_ECM_SUBSET=y
+CONFIG_USB_CONFIGFS_RNDIS=y
+CONFIG_USB_CONFIGFS_EEM=y
+CONFIG_USB_CONFIGFS_MASS_STORAGE=y
+CONFIG_USB_CONFIGFS_F_LB_SS=y
+CONFIG_USB_CONFIGFS_F_FS=y
+CONFIG_USB_CONFIGFS_F_HID=y
+CONFIG_USB_CONFIGFS_F_PRINTER=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_ONESHOT=y
+CONFIG_LEDS_TRIGGER_MTD=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_LEDS_TRIGGER_TRANSIENT=y
+CONFIG_LEDS_TRIGGER_PANIC=y
+# CONFIG_VIRTIO_MENU is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_HPE_GXP_XREG=y
+CONFIG_HPE_GXP_FN2=y
+CONFIG_HPE_GXP_CSM=y
+CONFIG_HPE_GXP_SROM=y
+CONFIG_FANOTIFY=y
+CONFIG_OVERLAY_FS=y
+CONFIG_OVERLAY_FS_REDIRECT_DIR=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_JFFS2_FS=y
+# CONFIG_JFFS2_FS_WRITEBUFFER is not set
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_FS_XATTR=y
+# CONFIG_JFFS2_FS_POSIX_ACL is not set
+# CONFIG_JFFS2_FS_SECURITY is not set
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_XZ=y
+CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
+# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
+CONFIG_CRYPTO_CCM=y
+CONFIG_CRYPTO_GCM=y
+CONFIG_CRYPTO_CRC32C=y
+CONFIG_CRYPTO_ARC4=y
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_LZO=y
+CONFIG_CRYPTO_ZSTD=y
+CONFIG_CRYPTO_USER_API_HASH=y
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC16=y
+# CONFIG_XZ_DEC_ARM is not set
+# CONFIG_XZ_DEC_ARMTHUMB is not set
+CONFIG_DMA_API_DEBUG=y
+CONFIG_PRINTK_TIME=y
+CONFIG_BOOT_PRINTK_DELAY=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_FUNCTION_PROFILER=y
+CONFIG_STACK_TRACER=y
+CONFIG_SCHED_TRACER=y
+CONFIG_STRICT_DEVMEM=y
+CONFIG_DEBUG_USER=y
+CONFIG_DEBUG_LL=y
+CONFIG_DEBUG_LL_UART_8250=y
+CONFIG_DEBUG_UART_PHYS=0xC00000F0
+CONFIG_DEBUG_UART_VIRT=0xF00000F0
+CONFIG_DEBUG_UART_8250_SHIFT=0
+CONFIG_EARLY_PRINTK=y
+CONFIG_TEST_KSTRTOX=y
-- 
2.17.1

