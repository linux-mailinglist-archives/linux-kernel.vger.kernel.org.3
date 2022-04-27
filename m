Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530A2510F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357544AbiD0DmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244576AbiD0DmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:42:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC0F74DC5;
        Tue, 26 Apr 2022 20:38:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kp4H03v8fz4xLS;
        Wed, 27 Apr 2022 13:38:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651030732;
        bh=6Re7NS6zeMbnfZ6+OS0kwjcSX7gccswbyAJdHPaTY5w=;
        h=Date:From:To:Cc:Subject:From;
        b=eWhbWk2W0/SLtRjhUfOSgsPKP8/6B+H6gjc3R7pGxz4DNkip6rImW6vO2bJwDOqdm
         H/9Lb9LszwUWuj8Nezc3O4W3t0hs9HI9nihrozR1DdUEV4+bWn9PHq/qoMsZlFzvMv
         jMzYXgUDuQsukSZW32fCJ6blH0JkbmhjyWpcf3NAwcyaDau7QxKqPiFz0/OpbS2gMl
         uts9wx+9x+E933X89f9U9uVer7WiHWobrVDCcZkFWCYmGh23B7iRNl8CCUj7Xr7Pn0
         9dMvdRVRHbf9y+QlXRqJsxpyvlptLbEMfCOEw9rnwVeZz1hCiQ07DGJ6Fvnm4+k09m
         X+NQ6YSzsCT4A==
Date:   Wed, 27 Apr 2022 13:38:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Sumit Saxena <sumit.saxena@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20220427133851.6ff8b0cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3qmWCjs5.G.SBIzxA3FR/cj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3qmWCjs5.G.SBIzxA3FR/cj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from <command-line>:
./usr/include/scsi/scsi_bsg_mpi3mr.h:96:9: error: unknown type name '__le32'
   96 |         __le32             information_length;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:97:9: error: unknown type name 'u8'
   97 |         u8                 driver_signature[12];
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:98:9: error: unknown type name 'u8'
   98 |         u8                 os_name[16];
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:99:9: error: unknown type name 'u8'
   99 |         u8                 os_version[12];
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:100:9: error: unknown type name 'u8'
  100 |         u8                 driver_name[20];
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:101:9: error: unknown type name 'u8'
  101 |         u8                 driver_version[32];
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:102:9: error: unknown type name 'u8'
  102 |         u8                 driver_release_date[20];
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:103:9: error: unknown type name '__le3=
2'
  103 |         __le32             driver_capabilities;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:128:9: error: unknown type name 'uint3=
2_t'
  128 |         uint32_t adp_type;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:129:9: error: unknown type name 'uint3=
2_t'
  129 |         uint32_t rsvd1;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:130:9: error: unknown type name 'uint3=
2_t'
  130 |         uint32_t pci_dev_id;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:131:9: error: unknown type name 'uint3=
2_t'
  131 |         uint32_t pci_dev_hw_rev;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:132:9: error: unknown type name 'uint3=
2_t'
  132 |         uint32_t pci_subsys_dev_id;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:133:9: error: unknown type name 'uint3=
2_t'
  133 |         uint32_t pci_subsys_ven_id;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:134:9: error: unknown type name 'uint3=
2_t'
  134 |         uint32_t pci_dev:5;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:135:9: error: unknown type name 'uint3=
2_t'
  135 |         uint32_t pci_func:3;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:136:9: error: unknown type name 'uint3=
2_t'
  136 |         uint32_t pci_bus:8;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:137:9: error: unknown type name 'uint1=
6_t'
  137 |         uint16_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:138:9: error: unknown type name 'uint3=
2_t'
  138 |         uint32_t pci_seg_id;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:139:9: error: unknown type name 'uint3=
2_t'
  139 |         uint32_t app_intfc_ver;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:140:9: error: unknown type name 'uint8=
_t'
  140 |         uint8_t adp_state;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:141:9: error: unknown type name 'uint8=
_t'
  141 |         uint8_t rsvd3;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:142:9: error: unknown type name 'uint1=
6_t'
  142 |         uint16_t rsvd4;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:143:9: error: unknown type name 'uint3=
2_t'
  143 |         uint32_t rsvd5[2];
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:156:9: error: unknown type name 'uint8=
_t'
  156 |         uint8_t reset_type;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:157:9: error: unknown type name 'uint8=
_t'
  157 |         uint8_t rsvd1;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:158:9: error: unknown type name 'uint1=
6_t'
  158 |         uint16_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:169:9: error: unknown type name 'uint1=
6_t'
  169 |         uint16_t change_count;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:170:9: error: unknown type name 'uint1=
6_t'
  170 |         uint16_t rsvd;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:185:9: error: unknown type name 'uint1=
6_t'
  185 |         uint16_t handle;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:186:9: error: unknown type name 'uint1=
6_t'
  186 |         uint16_t perst_id;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:187:9: error: unknown type name 'uint3=
2_t'
  187 |         uint32_t target_id;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:188:9: error: unknown type name 'uint8=
_t'
  188 |         uint8_t bus_id;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:189:9: error: unknown type name 'uint8=
_t'
  189 |         uint8_t rsvd1;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:190:9: error: unknown type name 'uint1=
6_t'
  190 |         uint16_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:203:9: error: unknown type name 'uint1=
6_t'
  203 |         uint16_t num_devices;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:204:9: error: unknown type name 'uint1=
6_t'
  204 |         uint16_t rsvd1;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:205:9: error: unknown type name 'uint3=
2_t'
  205 |         uint32_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:218:9: error: unknown type name 'uint1=
6_t'
  218 |         uint16_t max_entries;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:219:9: error: unknown type name 'uint1=
6_t'
  219 |         uint16_t rsvd;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:231:9: error: unknown type name 'uint1=
6_t'
  231 |         uint16_t pel_locale;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:232:9: error: unknown type name 'uint8=
_t'
  232 |         uint8_t pel_class;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:233:9: error: unknown type name 'uint8=
_t'
  233 |         uint8_t rsvd;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:246:9: error: unknown type name 'uint8=
_t'
  246 |         uint8_t valid_entry;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:247:9: error: unknown type name 'uint8=
_t'
  247 |         uint8_t rsvd1;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:248:9: error: unknown type name 'uint1=
6_t'
  248 |         uint16_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:249:9: error: unknown type name 'uint8=
_t'
  249 |         uint8_t data[1]; /* Variable length Array */
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:277:9: error: unknown type name 'uint8=
_t'
  277 |         uint8_t buf_type;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:278:9: error: unknown type name 'uint8=
_t'
  278 |         uint8_t status;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:279:9: error: unknown type name 'uint8=
_t'
  279 |         uint8_t trigger_type;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:280:9: error: unknown type name 'uint8=
_t'
  280 |         uint8_t rsvd1;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:281:9: error: unknown type name 'uint1=
6_t'
  281 |         uint16_t size;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:282:9: error: unknown type name 'uint1=
6_t'
  282 |         uint16_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:283:9: error: unknown type name 'uint6=
4_t'
  283 |         uint64_t trigger_data;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:284:9: error: unknown type name 'uint3=
2_t'
  284 |         uint32_t rsvd3;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:285:9: error: unknown type name 'uint3=
2_t'
  285 |         uint32_t rsvd4;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:303:9: error: unknown type name 'uint8=
_t'
  303 |         uint8_t num_hdb_types;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:304:9: error: unknown type name 'uint8=
_t'
  304 |         uint8_t rsvd1;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:305:9: error: unknown type name 'uint1=
6_t'
  305 |         uint16_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:306:9: error: unknown type name 'uint3=
2_t'
  306 |         uint32_t rsvd3;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:319:9: error: unknown type name 'uint8=
_t'
  319 |         uint8_t buf_type;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:320:9: error: unknown type name 'uint8=
_t'
  320 |         uint8_t rsvd1;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:321:9: error: unknown type name 'uint1=
6_t'
  321 |         uint16_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:335:9: error: unknown type name 'uint8=
_t'
  335 |         uint8_t buf_type;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:336:9: error: unknown type name 'uint8=
_t'
  336 |         uint8_t rsvd1;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:337:9: error: unknown type name 'uint1=
6_t'
  337 |         uint16_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:338:9: error: unknown type name 'uint3=
2_t'
  338 |         uint32_t start_offset;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:339:9: error: unknown type name 'uint3=
2_t'
  339 |         uint32_t length;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:351:9: error: unknown type name 'uint8=
_t'
  351 |         uint8_t page_type;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:352:9: error: unknown type name 'uint8=
_t'
  352 |         uint8_t rsvd1;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:353:9: error: unknown type name 'uint1=
6_t'
  353 |         uint16_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:365:9: error: unknown type name 'uint8=
_t'
  365 |         uint8_t mrioc_id;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:366:9: error: unknown type name 'uint8=
_t'
  366 |         uint8_t opcode;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:367:9: error: unknown type name 'uint1=
6_t'
  367 |         uint16_t rsvd1;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:368:9: error: unknown type name 'uint3=
2_t'
  368 |         uint32_t rsvd2[4];
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:380:9: error: unknown type name 'uint8=
_t'
  380 |         uint8_t mpi_reply_type;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:381:9: error: unknown type name 'uint8=
_t'
  381 |         uint8_t rsvd1;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:382:9: error: unknown type name 'uint1=
6_t'
  382 |         uint16_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:383:9: error: unknown type name 'uint8=
_t'
  383 |         uint8_t reply_buf[1];
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:396:9: error: unknown type name 'uint8=
_t'
  396 |         uint8_t buf_type;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:397:9: error: unknown type name 'uint8=
_t'
  397 |         uint8_t rsvd1;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:398:9: error: unknown type name 'uint1=
6_t'
  398 |         uint16_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:399:9: error: unknown type name 'uint3=
2_t'
  399 |         uint32_t buf_len;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:412:9: error: unknown type name 'uint8=
_t'
  412 |         uint8_t num_of_entries;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:413:9: error: unknown type name 'uint8=
_t'
  413 |         uint8_t rsvd1;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:414:9: error: unknown type name 'uint1=
6_t'
  414 |         uint16_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:415:9: error: unknown type name 'uint3=
2_t'
  415 |         uint32_t rsvd3;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:428:9: error: unknown type name 'uint8=
_t'
  428 |         uint8_t mrioc_id;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:429:9: error: unknown type name 'uint8=
_t'
  429 |         uint8_t rsvd1;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:430:9: error: unknown type name 'uint1=
6_t'
  430 |         uint16_t timeout;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:431:9: error: unknown type name 'uint3=
2_t'
  431 |         uint32_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:446:9: error: unknown type name 'uint8=
_t'
  446 |         uint8_t cmd_type;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:447:9: error: unknown type name 'uint8=
_t'
  447 |         uint8_t rsvd1;
      |         ^~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:448:9: error: unknown type name 'uint1=
6_t'
  448 |         uint16_t rsvd2;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:449:9: error: unknown type name 'uint3=
2_t'
  449 |         uint32_t rsvd3;
      |         ^~~~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:463:9: error: unknown type name '__le1=
6'
  463 |         __le16                     host_tag;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:464:9: error: unknown type name 'u8'
  464 |         u8                         ioc_use_only02;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:465:9: error: unknown type name 'u8'
  465 |         u8                         function;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:466:9: error: unknown type name '__le1=
6'
  466 |         __le16                     ioc_use_only04;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:467:9: error: unknown type name 'u8'
  467 |         u8                         ioc_use_only06;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:468:9: error: unknown type name 'u8'
  468 |         u8                         msg_flags;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:469:9: error: unknown type name '__le1=
6'
  469 |         __le16                     change_count;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:470:9: error: unknown type name '__le1=
6'
  470 |         __le16                     dev_handle;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:471:9: error: unknown type name '__le1=
6'
  471 |         __le16                     encapsulated_command_length;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:472:9: error: unknown type name '__le1=
6'
  472 |         __le16                     flags;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:473:9: error: unknown type name '__le3=
2'
  473 |         __le32                     data_length;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:474:9: error: unknown type name '__le3=
2'
  474 |         __le32                     reserved14[3];
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:475:9: error: unknown type name '__le3=
2'
  475 |         __le32                     command[MPI3_NVME_ENCAP_CMD_MAX];
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:479:9: error: unknown type name '__le1=
6'
  479 |         __le16                     host_tag;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:480:9: error: unknown type name 'u8'
  480 |         u8                         ioc_use_only02;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:481:9: error: unknown type name 'u8'
  481 |         u8                         function;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:482:9: error: unknown type name '__le1=
6'
  482 |         __le16                     ioc_use_only04;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:483:9: error: unknown type name 'u8'
  483 |         u8                         ioc_use_only06;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:484:9: error: unknown type name 'u8'
  484 |         u8                         msg_flags;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:485:9: error: unknown type name '__le1=
6'
  485 |         __le16                     ioc_use_only08;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:486:9: error: unknown type name '__le1=
6'
  486 |         __le16                     ioc_status;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:487:9: error: unknown type name '__le3=
2'
  487 |         __le32                     ioc_log_info;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:488:9: error: unknown type name '__le3=
2'
  488 |         __le32                     nvme_completion_entry[4];
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:501:9: error: unknown type name '__le1=
6'
  501 |         __le16                     host_tag;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:502:9: error: unknown type name 'u8'
  502 |         u8                         ioc_use_only02;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:503:9: error: unknown type name 'u8'
  503 |         u8                         function;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:504:9: error: unknown type name '__le1=
6'
  504 |         __le16                     ioc_use_only04;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:505:9: error: unknown type name 'u8'
  505 |         u8                         ioc_use_only06;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:506:9: error: unknown type name 'u8'
  506 |         u8                         msg_flags;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:507:9: error: unknown type name '__le1=
6'
  507 |         __le16                     change_count;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:508:9: error: unknown type name '__le1=
6'
  508 |         __le16                     dev_handle;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:509:9: error: unknown type name '__le1=
6'
  509 |         __le16                     task_host_tag;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:510:9: error: unknown type name 'u8'
  510 |         u8                         task_type;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:511:9: error: unknown type name 'u8'
  511 |         u8                         reserved0f;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:512:9: error: unknown type name '__le1=
6'
  512 |         __le16                     task_request_queue_id;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:513:9: error: unknown type name '__le1=
6'
  513 |         __le16                     reserved12;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:514:9: error: unknown type name '__le3=
2'
  514 |         __le32                     reserved14;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:515:9: error: unknown type name 'u8'
  515 |         u8                         lun[8];
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:530:9: error: unknown type name '__le1=
6'
  530 |         __le16                     host_tag;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:531:9: error: unknown type name 'u8'
  531 |         u8                         ioc_use_only02;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:532:9: error: unknown type name 'u8'
  532 |         u8                         function;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:533:9: error: unknown type name '__le1=
6'
  533 |         __le16                     ioc_use_only04;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:534:9: error: unknown type name 'u8'
  534 |         u8                         ioc_use_only06;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:535:9: error: unknown type name 'u8'
  535 |         u8                         msg_flags;
      |         ^~
./usr/include/scsi/scsi_bsg_mpi3mr.h:536:9: error: unknown type name '__le1=
6'
  536 |         __le16                     ioc_use_only08;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:537:9: error: unknown type name '__le1=
6'
  537 |         __le16                     ioc_status;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:538:9: error: unknown type name '__le3=
2'
  538 |         __le32                     ioc_log_info;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:539:9: error: unknown type name '__le3=
2'
  539 |         __le32                     termination_count;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:540:9: error: unknown type name '__le3=
2'
  540 |         __le32                     response_data;
      |         ^~~~~~
./usr/include/scsi/scsi_bsg_mpi3mr.h:541:9: error: unknown type name '__le3=
2'
  541 |         __le32                     reserved18;
      |         ^~~~~~

Caused by commit

  a212ebe7d4b1 ("scsi: mpi3mr: Add support for driver commands")
  455aac4f7a13 ("scsi: mpi3mr: Move data structures/definitions from MPI he=
aders to uapi header")

I used the scsi-mkp tree from next-20220426 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/3qmWCjs5.G.SBIzxA3FR/cj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJoussACgkQAVBC80lX
0Gzd2wgAjYKkH0Rq5+mAWi9vEXdKMUSO4E2XmCaIqoPSLDgSC8KprAfDttIlNGPc
1WnVkHQwsuXR5g9vCuuX/+bjA47seBJSLLOa0gp+Qon9bWsaE2qmV9NZA5K+a3FX
B83wd9eoWVoEdSoEFNO5+OnBAMX9DzJYtzj3b3PwYVE7s0hVaPNdsJBzVUtB4tEB
mMq7eeu4vNWBZ+uMsVPYIEtEyDWTbpCS1HlYcHgJgArvIUbxOc01I8PglzFDnxjm
5BOhFjM0bZr9leKadUaK7dpuOIkT1NXBp2nfSwtpW3HLawiR496VRwxpEsgqWGF6
DdO6Mj6fxJvNyyagYxTQkT9XTJGtDA==
=RTjw
-----END PGP SIGNATURE-----

--Sig_/3qmWCjs5.G.SBIzxA3FR/cj--
