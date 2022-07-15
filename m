Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E04B576A92
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiGOXVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiGOXVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:21:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9378492843;
        Fri, 15 Jul 2022 16:21:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h17so8715013wrx.0;
        Fri, 15 Jul 2022 16:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=WP1k9JR3q2kpU+9oKdGOJLSJzHWZD7K59YLDv38ZoL0=;
        b=grQe+yEXMAPCAHSAunuX+EoiVPfPaejhQT4VwaCEMeCUCYiS6l2SyQ+aeoyOJw3W/7
         b/jqE9cF3bCn2ziZdfSb6fEy0GX2ElksprrDd81oEOgXVTI3qsGlBoKAQa6y3nwSwsRG
         sEMczA5h4N/eFYB44M5Az2PDZ0Yjbz6Zi13/hOvpc5c/nFP8lgWlrMYbfAYWe38h4/m/
         /V0lqiT4mi3lZ2yMbMIiXL0Obh7J+PAv5ltruzfU8STtUMcLI0c558Lz4vW/pRLc6CCb
         1Q9wT4cNdz0XdKTAlZR0vNdpNfWVoE4RSDZtTGmzHv9QotuiAu0xUblginxYtzkgUAKS
         AIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WP1k9JR3q2kpU+9oKdGOJLSJzHWZD7K59YLDv38ZoL0=;
        b=ZH6JdfNsZ1rQDm1pu9ile8LggVtFjgX4fDyXBPufm4MkIkZJm5R3Duu3PFj0lOyXeZ
         A8qrRqSIXKZes2FTPgXoUFp3Gx3XHh4FtnWJUnmNmRgYpeQpZoVWd1teu5jXEgayCHP+
         jUZMplx0sHutVjX6h7VPXnO8sWHAsqFMzf4RzrtVkU9SzPVFXr75npl1UNWkUGH4YEHJ
         PtwdQ5Ex+Hmtk8aqUEHe15dt379OUjCvKdLG25OnBShOuV2X6C86gTNMJUJB1pclHVN1
         RydZWXnilngiyYoWzEV4G54Iho1YnRN67Lg2Q4ceaXNZHLIW12LZRWzPACbQy1yl8N/T
         uXVQ==
X-Gm-Message-State: AJIora+Mp47cAF1aeQWM/CMLQDCxf2ba9czaqC7ftzY8j40QiO4nzxHe
        6GQdX3KPgCCcZHUjLNkIKlGrGvvZyiMo9Q==
X-Google-Smtp-Source: AGRyM1ssL3Q4jhmsPST6RCt9ekVCAqNaz9O0eEbF9UXtJQnJA9Q78S9gWF30tP2AdTeHULgC1Ae6NQ==
X-Received: by 2002:a5d:59ac:0:b0:21d:944a:8a0e with SMTP id p12-20020a5d59ac000000b0021d944a8a0emr14342183wrr.61.1657927259108;
        Fri, 15 Jul 2022 16:20:59 -0700 (PDT)
Received: from debian (host-78-150-47-22.as13285.net. [78.150.47.22])
        by smtp.gmail.com with ESMTPSA id bg10-20020a05600c3c8a00b003a0323463absm8144010wmb.45.2022.07.15.16.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 16:20:58 -0700 (PDT)
Date:   Sat, 16 Jul 2022 00:20:56 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: build failure of next-20220715 due to "cast from pointer to integer
 of different size"
Message-ID: <YtH2WLmSXX7qLV5X@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Not sure if it has been reported, builds of xtensa, csky and mips allmodsconfig
have failed to build next-20220715 with the error:

drivers/scsi/mpi3mr/mpi3mr_os.c: In function 'mpi3mr_queue_qd_reduction_event':
drivers/scsi/mpi3mr/mpi3mr_os.c:389:40: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  389 |         *(__le64 *)fwevt->event_data = (__le64)tg;
      |                                        ^
drivers/scsi/mpi3mr/mpi3mr_os.c: In function 'mpi3mr_fwevt_bh':
drivers/scsi/mpi3mr/mpi3mr_os.c:1655:22: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
 1655 |                 tg = (struct mpi3mr_throttle_group_info *)
      |                   


--
Regards
Sudip
