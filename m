Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C42D5990C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 01:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbiHRW7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHRW7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:59:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79084C6EAB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:59:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso3233886pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=ALWWrP5HVt5qQ2+zTa1oCLsCZzNeHgR9rx8qLVeRMJg=;
        b=ljveytXU1poQmxaONi5cV2IFQ2mRarIhWwpaKiBJavb6bi3Ul5IEklgnnjACyK7hGW
         EP4ZCRnG68gq37g+EXsOtfO5QykniOB/HINtNgxLBJ1tu6uXQnAZfC6ma/iES5gG0oo0
         2HELGtK3XWaYf29v7ccYUSC3fTzu72Whx3CYbEmvVugRCuImqmQ23UVppgcsMREDQ+eF
         UDKRTsoawL9y3pID8+M4ZwmFGLQDjCVgyoDShacsvzUFcP0kose/6JO8iWMlLeE4bGxl
         Dx7ZrsSCpkBh3yE2jPNITZHi7eevoA6riW9Q6zZvFZ300BZbPHTY/fp70KETwpsdltfE
         SS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=ALWWrP5HVt5qQ2+zTa1oCLsCZzNeHgR9rx8qLVeRMJg=;
        b=xBsbGbCNdXxPeTGRxajgqEI2Oi+Uj1Dt0R1+5hJDaPmGL5zOg+iTZ8drS7VKcUPTJV
         cJvHnW7Lsf3zxah3wxwQJ+VE+IMptoZjaDHpRJSdK65PNgDScRFp1dtPLpkwBekMX0Xu
         hfyPe8ExI0853M35G/+CKvodoTBriH3rlTzbQxAtBNuaCFCQEzzmkjk7VBdbGXXjlR90
         nv1vwciFO1BuLn75J14/hJRBAiUfHFdWHD+WqWMo52DrVo8L+CgyC9GomNZDwnTXYYoa
         q18M8FQgOMKZVcRdMJ7eDTNMkb+YsynfBkpAfEIooxVUNXdS0zGNXou9g5ZfVFosbKlx
         ExEQ==
X-Gm-Message-State: ACgBeo3DRkhDKkbhrtp6PiN/6fgH5oFJ1v4OOQlyUiG3weDNTLBzhuRn
        /6Lj4LGKhMamkzIR2uV5g/g=
X-Google-Smtp-Source: AA6agR78d796nryGqRV/n2Jrx2+0YkTYgcC3HjeGHUCr7Lm66rlOb1GN0FP5KXn8LbF9ZXM4BNg8DA==
X-Received: by 2002:a17:903:2585:b0:172:9ac6:30f3 with SMTP id jb5-20020a170903258500b001729ac630f3mr4773698plb.0.1660863576883;
        Thu, 18 Aug 2022 15:59:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h135-20020a62838d000000b0052d432b4cc0sm2182616pfe.33.2022.08.18.15.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:59:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 15:59:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Isaac Manjarres <isaacmanjarres@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Message-ID: <20220818225932.GA3433999@roeck-us.net>
References: <20220815211919.2028890-1-isaacmanjarres@google.com>
 <20220816042507.GB1108868@roeck-us.net>
 <YvsoYzIhOtX9DOi2@google.com>
 <20220816111311.GC1108868@roeck-us.net>
 <YvvQOBk9T3J1uX8k@google.com>
 <20220817010559.GA1880847@roeck-us.net>
 <YvxAfiSOrzy7/c1J@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvxAfiSOrzy7/c1J@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 06:12:30PM -0700, Isaac Manjarres wrote:
> > However, imx25-pdk fails to shut down when booting from usb
> > drive. I cross checked that this does not happen without the above patch.
> > 
> > Guenter
> 
> Can you please share the following for your imx25-pdk environment?
> qemu commandline, defconfig, dtb, and baseline kernel commit you're
> using for testing.
> 
It doesn't only affect imx25-pdk but also mcimx7d-sabre.
Problem is the same for both: Reboot after booting from
usb drive doesn't work; the system is stuck in shutdown.
Typical tail of log sequence:

Requesting system reboot
sd 0:0:0:0: [sda] Synchronizing SCSI cache
ci_hdrc ci_hdrc.1: remove, state 4
usb usb2: USB disconnect, device number 1
ci_hdrc ci_hdrc.1: USB bus 2 deregistered
ci_hdrc ci_hdrc.0: remove, state 1
usb usb1: USB disconnect, device number 1
usb 1-1: USB disconnect, device number 2
sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result: hostbyte=0x01 driverbyte=DRIVER_OK

[ stuck here until qemu is killed ]

qemu command line:

qemu-system-arm -M imx25-pdk -m 128 \
     -kernel arch/arm/boot/zImage -no-reboot -snapshot \
     -usb -device usb-storage,drive=d0,bus=usb-bus.0 \
     -drive file=rootfs-armv5.ext2,if=none,id=d0,format=raw \
     --append "root=/dev/sda rootwait console=ttymxc0,115200" \
     -dtb arch/arm/boot/dts/imx25-pdk.dtb \
     -nographic -monitor null -serial stdio

Root file system is
https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/rootfs-armv5.ext2.gz

defconfig is below.

Hope this helps,
Guenter

---
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_CGROUPS=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_EXPERT=y
CONFIG_PROFILING=y
CONFIG_ARCH_MULTI_V4T=y
CONFIG_ARCH_MULTI_V5=y
# CONFIG_ARCH_MULTI_V7 is not set
CONFIG_ARCH_MXC=y
CONFIG_SOC_IMX1=y
CONFIG_SOC_IMX25=y
CONFIG_SOC_IMX27=y
CONFIG_AEABI=y
CONFIG_PM_DEBUG=y
CONFIG_KPROBES=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_SWAP is not set
CONFIG_SLAB=y
# CONFIG_COMPAT_BRK is not set
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_PNP=y
# CONFIG_INET_DIAG is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_WIRELESS is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_IMX_WEIM=y
CONFIG_MTD=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_CFI=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
# CONFIG_MTD_CFI_I2 is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_RAW_NAND=y
CONFIG_MTD_UBI=y
CONFIG_OF_UNITTEST=y
CONFIG_VIRTIO_BLK=y
CONFIG_EEPROM_AT25=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_BSG is not set
CONFIG_SCSI_VIRTIO=y
CONFIG_ATA=y
CONFIG_PATA_IMX=y
CONFIG_NETDEVICES=y
CONFIG_VIRTIO_NET=y
CONFIG_CS89x0_PLATFORM=y
CONFIG_DM9000=y
CONFIG_SMC91X=y
CONFIG_SMC911X=y
CONFIG_SMSC911X=y
CONFIG_SMSC_PHY=y
CONFIG_USB_USBNET=y
# CONFIG_WLAN is not set
CONFIG_INPUT_EVDEV=y
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_IMX=y
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_TOUCHSCREEN_MX25=y
CONFIG_TOUCHSCREEN_MC13783=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_IMX=y
CONFIG_SERIAL_IMX_CONSOLE=y
# CONFIG_HW_RANDOM is not set
CONFIG_SPI=y
CONFIG_SPI_IMX=y
CONFIG_SPI_SPIDEV=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_MXC=y
CONFIG_W1=y
CONFIG_W1_MASTER_MXC=y
CONFIG_W1_SLAVE_THERM=y
CONFIG_HWMON=m
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_WATCHDOG=y
CONFIG_IMX2_WDT=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MX25_TSADC=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_MEDIA_SUPPORT=y
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_CODA=y
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_FB=y
CONFIG_FB_IMX=y
CONFIG_LCD_L4F00242T03=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_LOGO=y
CONFIG_SOUND=y
CONFIG_SND=y
# CONFIG_SND_ARM is not set
# CONFIG_SND_SPI is not set
CONFIG_SND_SOC=y
CONFIG_SND_IMX_SOC=y
CONFIG_USB_HID=m
CONFIG_USB=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_STORAGE=y
CONFIG_USB_UAS=y
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_UDC=y
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GADGET=y
CONFIG_USB_ETH=m
CONFIG_MMC=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_ESDHC_IMX=y
CONFIG_MMC_MXC=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_IMXDI=y
CONFIG_RTC_DRV_MC13XXX=y
CONFIG_RTC_DRV_MXC=y
CONFIG_DMADEVICES=y
CONFIG_IMX_DMA=y
CONFIG_IMX_SDMA=y
CONFIG_DMATEST=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MMIO=y
# CONFIG_IOMMU_SUPPORT is not set
CONFIG_IIO=y
CONFIG_FSL_MX25_ADC=y
CONFIG_PWM=y
CONFIG_PWM_IMX1=y
CONFIG_PWM_IMX27=y
CONFIG_EXT3_FS=y
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_BTRFS_FS=y
# CONFIG_DNOTIFY is not set
CONFIG_ISO9660_FS=y
CONFIG_VFAT_FS=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_TMPFS=y
CONFIG_JFFS2_FS=y
CONFIG_UBIFS_FS=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=m
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
CONFIG_CRC32_SELFTEST=y
CONFIG_GLOB_SELFTEST=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_DEBUG_INFO_DWARF5=y
CONFIG_KFENCE=y
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_DEBUG_LIST=y
CONFIG_RCU_EQS_DEBUG=y
CONFIG_KUNIT=y
CONFIG_KUNIT_TEST=y
CONFIG_TEST_SORT=y
CONFIG_RBTREE_TEST=y
CONFIG_INTERVAL_TREE_TEST=y
CONFIG_STRING_SELFTEST=y
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
CONFIG_RESOURCE_KUNIT_TEST=y
CONFIG_SYSCTL_KUNIT_TEST=y
CONFIG_LIST_KUNIT_TEST=y
CONFIG_CMDLINE_KUNIT_TEST=y
CONFIG_MEMCPY_KUNIT_TEST=y
