Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106C85876F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiHBGFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbiHBGFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:05:16 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3538125D6;
        Mon,  1 Aug 2022 23:05:13 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oIl1c-00745v-IF; Tue, 02 Aug 2022 16:05:06 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 02 Aug 2022 14:05:04 +0800
Date:   Tue, 2 Aug 2022 14:05:04 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Update for 5.20
Message-ID: <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
References: <20210708030913.GA32097@gondor.apana.org.au>
 <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v5.20-p1

for you to fetch changes up to af5d35b83f642399c719ea9a8599a13b8a0c4167:

  crypto: tcrypt - Remove the static variable initialisations to NULL (2022-07-29 18:29:18 +0800)

----------------------------------------------------------------
This update includes the following changes:

API:

- Make proc files report fips module name and version.

Algorithms:

- Move generic SHA1 code into lib/crypto.
- Implement Chinese Remainder Theorem for RSA.
- Remove blake2s.
- Add XCTR with x86/arm64 acceleration.
- Add POLYVAL with x86/arm64 acceleration.
- Add HCTR2.
- Add ARIA.

Drivers:

- Add support for new CCP/PSP device ID in ccp.

----------------------------------------------------------------
Alexey Khoroshilov (1):
      crypto: sun8i-ss - fix infinite loop in sun8i_ss_setup_ivs()

Andre Przywara (1):
      crypto: qat - replace get_current_node() with numa_node_id()

Andrew Davis (2):
      crypto: sa2ul - Set the supported_algos bits individually
      crypto: sa2ul - Check engine status before enabling

Bagas Sanjaya (2):
      Documentation: qat: Use code block for qat sysfs example
      Documentation: qat: rewrite description

Christophe JAILLET (2):
      crypto: ccree - Remove a useless dma_supported() call
      crypto: hisilicon/zip - Use the bitmap API to allocate bitmaps

Claudiu Beznea (2):
      crypto: atmel-sha - initialize sha_dd while declaring
      crypto: atmel-tdes - initialize tdes_dd while declaring

Colin Ian King (1):
      crypto: x86/blowfish - remove redundant assignment to variable nytes

Dan Carpenter (2):
      crypto: sun8i-ss - fix error codes in allocate_flows()
      crypto: sun8i-ss - Fix error codes for dma_mapping_error()

Eric Biggers (3):
      crypto: lib - move lib/sha1.c into lib/crypto/
      crypto: lib - make the sha1 library optional
      crypto: lib - add module license to libsha1

GUO Zihua (1):
      crypto: arm64/poly1305 - fix a read out-of-bound

Giovanni Cabiddu (4):
      crypto: qat - expose device state through sysfs for 4xxx
      crypto: qat - change behaviour of adf_cfg_add_key_value_param()
      crypto: qat - relocate and rename adf_sriov_prepare_restart()
      crypto: qat - expose device config through sysfs for 4xxx

Herbert Xu (1):
      crypto: vmx - Fix warning on p8_ghash_alg

Ignat Korchagin (3):
      crypto: rsa - implement Chinese Remainder Theorem for faster private key operations
      crypto: testmgr - populate RSA CRT parameters in RSA test vectors
      crypto: testmgr - some more fixes to RSA test vectors

Jakub Kicinski (1):
      crypto: caam/qi2 - switch to netif_napi_add_tx_weight()

Jason A. Donenfeld (3):
      crypto: memneq - move into lib/
      crypto: blake2s - remove shash module
      crypto: lib/blake2s - reduce stack frame usage in self test

Jason Wang (3):
      crypto: twofish - Fix comment typo
      hwrng: via - Fix comment typo
      crypto: tcrypt - Remove the static variable initialisations to NULL

Jiang Jian (6):
      crypto: nx - drop unexpected word "the"
      crypto: ux500/hash - drop unexpected word "the"
      crypto: cavium - fix typos in comments
      crypto: caam - drop unexpected word 'a' in comments
      crypto: caam - drop unexpected word 'for' in comments
      crypto: vmx - drop unexpected word 'for' in comments

Jianglei Nie (1):
      crypto: hisilicon/sec - fix inconsistent argument

Jilin Yuan (1):
      crypto: arm64/aes-neon - Fix typo in comment

John Allen (1):
      crypto: ccp - Use kzalloc for sev ioctl interfaces to prevent kernel memory leak

Julia Lawall (2):
      crypto: hisilicon/sec - fix typos in comment
      crypto: ccp - fix typo in comment

Kai Ye (2):
      crypto: hisilicon/sec - only HW V2 needs to change the BD err detection
      crypto: hisilicon/sec - fix auth key size error

Liang He (2):
      crypto: amcc - Hold the reference returned by of_find_compatible_node
      crypto: nx - Hold the reference returned by of_find_compatible_node

Mario Limonciello (1):
      crypto: ccp - Add support for new CCP/PSP device ID

Nathan Huckleberry (9):
      crypto: xctr - Add XCTR support
      crypto: polyval - Add POLYVAL support
      crypto: hctr2 - Add HCTR2 support
      crypto: x86/aesni-xctr - Add accelerated implementation of XCTR
      crypto: arm64/aes-xctr - Add accelerated implementation of XCTR
      crypto: arm64/aes-xctr - Improve readability of XCTR and CTR modes
      crypto: x86/polyval - Add PCLMULQDQ accelerated implementation of POLYVAL
      crypto: arm64/polyval - Add PMULL accelerated implementation of POLYVAL
      fscrypt: Add HCTR2 support for filename encryption

Ofer Heifetz (1):
      crypto: inside-secure - fix packed bit-field result descriptor

Pali Rohár (1):
      crypto: inside-secure - Add missing MODULE_DEVICE_TABLE for of

Peng Wu (1):
      crypto: sun8i-ss - fix a NULL vs IS_ERR() check in sun8i_ss_hashkey

Qian Cai (1):
      crypto: arm64/gcm - Select AEAD for GHASH_ARM64_CE

Randy Dunlap (1):
      crypto: rmd160 - fix Kconfig "its" grammar

Shijith Thotton (2):
      crypto: octeontx2 - add firmware version in devlink info
      crypto: octeontx2 - fix potential null pointer access

Taehee Yoo (2):
      crypto: aria - Implement ARIA symmetric cipher algorithm
      crypto: testmgr - add ARIA testmgr tests

Tom Lendacky (1):
      crypto: ccp - During shutdown, check SEV data pointer before using

Uwe Kleine-König (9):
      crypto: atmel-ecc - Remove duplicated error reporting in .remove()
      crypto: atmel-aes - Drop if with an always false condition
      crypto: atmel-sha - Drop if with an always false condition
      crypto: atmel-tdes - Drop if with an always false condition
      crypto: omap-aes - Drop if with an always false condition
      crypto: omap-des - Drop if with an always false condition
      crypto: omap-sham - Drop if with an always false condition
      crypto: s5p-sss - Drop if with an always false condition
      crypto: keembay-ocs-ecc - Drop if with an always false condition

Vladis Dronov (1):
      crypto: fips - make proc files report fips module name and version

Weili Qian (4):
      crypto: hisilicon/trng - fix local variable type
      crypto: hisilicon/qm - add functions for releasing resources
      crypto: hisilicon/qm - move alloc qm->wq to qm.c
      crypto: hisilicon/qm - modify event irq processing

Yoan Picchi (1):
      crypto: qat - Removes the x86 dependency on the QAT drivers

Yuan Can (1):
      crypto: ccree - Add missing clk_disable_unprepare() in cc_pm_resume()

Zhengchao Shao (3):
      crypto: hisilicon/sec - don't sleep when in softirq
      crypto: hisilicon - Kunpeng916 crypto driver don't sleep when in softirq
      crypto: hisilicon/hpre - don't use GFP_KERNEL to alloc mem during softirq

Zhou Wang (1):
      MAINTAINERS: update HiSilicon ZIP and QM maintainers

lei he (1):
      crypto: testmgr - fix version number of RSA tests

shaom Deng (1):
      cyrpto: powerpc/aes - delete the rebundant word "block" in comments

 Documentation/ABI/testing/sysfs-driver-qat         |   49 +
 Documentation/filesystems/fscrypt.rst              |   22 +-
 MAINTAINERS                                        |   15 +-
 arch/arm/crypto/Kconfig                            |    2 +-
 arch/arm/crypto/Makefile                           |    4 +-
 arch/arm/crypto/blake2s-shash.c                    |   75 -
 arch/arm64/crypto/Kconfig                          |   10 +-
 arch/arm64/crypto/Makefile                         |    3 +
 arch/arm64/crypto/aes-glue.c                       |   80 +-
 arch/arm64/crypto/aes-modes.S                      |  349 +-
 arch/arm64/crypto/aes-neon.S                       |    2 +-
 arch/arm64/crypto/poly1305-glue.c                  |    2 +-
 arch/arm64/crypto/polyval-ce-core.S                |  361 ++
 arch/arm64/crypto/polyval-ce-glue.c                |  191 +
 arch/powerpc/crypto/aes-spe-glue.c                 |    2 +-
 arch/x86/crypto/Makefile                           |    7 +-
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S            |  232 +-
 arch/x86/crypto/aesni-intel_glue.c                 |  114 +-
 arch/x86/crypto/blake2s-glue.c                     |    3 +-
 arch/x86/crypto/blake2s-shash.c                    |   77 -
 arch/x86/crypto/blowfish_glue.c                    |    4 +-
 arch/x86/crypto/polyval-clmulni_asm.S              |  321 ++
 arch/x86/crypto/polyval-clmulni_glue.c             |  203 +
 crypto/Kconfig                                     |   99 +-
 crypto/Makefile                                    |    7 +-
 crypto/aria.c                                      |  288 ++
 crypto/blake2s_generic.c                           |   75 -
 crypto/fips.c                                      |   35 +-
 crypto/hctr2.c                                     |  581 +++
 crypto/polyval-generic.c                           |  245 +
 crypto/rsa.c                                       |   78 +-
 crypto/tcrypt.c                                    |   62 +-
 crypto/testmgr.c                                   |   75 +-
 crypto/testmgr.h                                   | 4830 ++++++++++++++++++--
 crypto/twofish_common.c                            |    2 +-
 crypto/xctr.c                                      |  191 +
 drivers/char/hw_random/via-rng.c                   |    2 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |    1 +
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c  |   16 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c  |   10 +-
 drivers/crypto/amcc/crypto4xx_core.c               |   40 +-
 drivers/crypto/atmel-aes.c                         |    3 +-
 drivers/crypto/atmel-ecc.c                         |   12 +-
 drivers/crypto/atmel-sha.c                         |    5 +-
 drivers/crypto/atmel-tdes.c                        |    5 +-
 drivers/crypto/caam/caamalg_qi2.c                  |    7 +-
 drivers/crypto/caam/caamhash_desc.c                |    2 +-
 drivers/crypto/caam/qi.c                           |    6 +-
 drivers/crypto/cavium/cpt/cpt_hw_types.h           |    2 +-
 drivers/crypto/ccp/ccp-dev.h                       |    2 +-
 drivers/crypto/ccp/sev-dev.c                       |   12 +-
 drivers/crypto/ccp/sp-pci.c                        |    7 +
 drivers/crypto/ccree/cc_driver.c                   |   13 +-
 drivers/crypto/ccree/cc_pm.c                       |    2 +
 drivers/crypto/hisilicon/hpre/hpre_crypto.c        |    2 +-
 drivers/crypto/hisilicon/qm.c                      |  203 +-
 drivers/crypto/hisilicon/sec/sec_algs.c            |   14 +-
 drivers/crypto/hisilicon/sec/sec_drv.c             |    2 +-
 drivers/crypto/hisilicon/sec/sec_drv.h             |    2 +-
 drivers/crypto/hisilicon/sec2/sec.h                |    6 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c         |   26 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.h         |    1 +
 drivers/crypto/hisilicon/sec2/sec_main.c           |   39 +-
 drivers/crypto/hisilicon/trng/trng.c               |    2 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c          |   10 +-
 drivers/crypto/hisilicon/zip/zip_main.c            |   17 +-
 drivers/crypto/inside-secure/safexcel.c            |    2 +
 drivers/crypto/inside-secure/safexcel.h            |   18 +-
 drivers/crypto/keembay/keembay-ocs-ecc.c           |    2 -
 .../crypto/marvell/octeontx2/otx2_cpt_devlink.c    |   40 +-
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.c    |   17 +-
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.h    |    3 +
 drivers/crypto/nx/nx-common-powernv.c              |    2 +-
 drivers/crypto/nx/nx-common-pseries.c              |    5 +-
 drivers/crypto/omap-aes.c                          |    4 -
 drivers/crypto/omap-des.c                          |    4 -
 drivers/crypto/omap-sham.c                         |    3 +-
 drivers/crypto/qat/Kconfig                         |   14 +-
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c     |    1 +
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h     |    1 +
 drivers/crypto/qat/qat_4xxx/adf_drv.c              |    6 +-
 drivers/crypto/qat/qat_common/Makefile             |    1 +
 drivers/crypto/qat/qat_common/adf_accel_devices.h  |    1 +
 drivers/crypto/qat/qat_common/adf_cfg.c            |   41 +-
 drivers/crypto/qat/qat_common/adf_common_drv.h     |    8 +-
 drivers/crypto/qat/qat_common/adf_init.c           |   26 +
 drivers/crypto/qat/qat_common/adf_sriov.c          |   28 +-
 drivers/crypto/qat/qat_common/adf_sysfs.c          |  191 +
 drivers/crypto/qat/qat_common/qat_algs.c           |    4 +-
 drivers/crypto/qat/qat_common/qat_asym_algs.c      |    4 +-
 drivers/crypto/s5p-sss.c                           |    3 -
 drivers/crypto/sa2ul.c                             |   25 +-
 drivers/crypto/sa2ul.h                             |    1 +
 drivers/crypto/ux500/hash/hash_core.c              |    2 +-
 drivers/crypto/vmx/ghash.c                         |    1 +
 drivers/crypto/vmx/ghashp8-ppc.pl                  |    2 +-
 fs/crypto/fscrypt_private.h                        |    2 +-
 fs/crypto/keysetup.c                               |    7 +
 fs/crypto/policy.c                                 |   14 +-
 include/crypto/aria.h                              |  461 ++
 include/crypto/internal/blake2s.h                  |  108 -
 include/crypto/polyval.h                           |   22 +
 include/linux/hisi_acc_qm.h                        |    8 +-
 include/uapi/linux/fscrypt.h                       |    3 +-
 init/Kconfig                                       |    1 +
 lib/Kconfig                                        |    3 +
 lib/Makefile                                       |    3 +-
 lib/crypto/Kconfig                                 |    4 +
 lib/crypto/Makefile                                |    3 +
 lib/crypto/blake2s-selftest.c                      |   41 +
 lib/crypto/blake2s.c                               |   37 +-
 lib/{ => crypto}/sha1.c                            |    3 +
 {crypto => lib}/memneq.c                           |    0
 lib/mpi/mpi-add.c                                  |    2 +-
 lib/mpi/mpi-mul.c                                  |    1 +
 net/ipv6/Kconfig                                   |    1 +
 116 files changed, 9147 insertions(+), 1204 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-qat
 delete mode 100644 arch/arm/crypto/blake2s-shash.c
 create mode 100644 arch/arm64/crypto/polyval-ce-core.S
 create mode 100644 arch/arm64/crypto/polyval-ce-glue.c
 delete mode 100644 arch/x86/crypto/blake2s-shash.c
 create mode 100644 arch/x86/crypto/polyval-clmulni_asm.S
 create mode 100644 arch/x86/crypto/polyval-clmulni_glue.c
 create mode 100644 crypto/aria.c
 delete mode 100644 crypto/blake2s_generic.c
 create mode 100644 crypto/hctr2.c
 create mode 100644 crypto/polyval-generic.c
 create mode 100644 crypto/xctr.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_sysfs.c
 create mode 100644 include/crypto/aria.h
 create mode 100644 include/crypto/polyval.h
 rename lib/{ => crypto}/sha1.c (98%)
 rename {crypto => lib}/memneq.c (100%)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
