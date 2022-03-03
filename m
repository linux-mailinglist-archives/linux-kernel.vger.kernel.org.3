Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E174CBF5A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiCCOCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiCCOCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:02:19 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E080DDB48B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 06:01:31 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id u17-20020a056830231100b005ad13358af9so4638444ote.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 06:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4xxxnNbsJRbysmHtNs1+hKG4EmqXsn61w9Qzk6rjI0=;
        b=fFzQrMzFfz2RW++RdgvDlaExWAPN4cYNgBtNg6gWfdP4EdYjCnaVhHaEPIW6KD62G3
         rDOcuMmZMhnZgwif05a1S5NrWxBOzzgjfC6G4Ec870EX9WEuzE6PERhudcxmZuctk9nY
         kMUrToeEkH3yIOSFLdymiFrIPfAuCJoMcRpOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4xxxnNbsJRbysmHtNs1+hKG4EmqXsn61w9Qzk6rjI0=;
        b=TaK6OCcBMG1B0tpT0+9zyrWHK7iFUBXJRMpY7jycj2H8j/I2kqpCUssN0GjzuQB1ct
         NjgiIyItAPu0e2epM5Wq8FTievRKQfLF9VR2hVBi87fZEmU5brrtDekenQ0Zz14GGs1n
         UnXClUpqwA0ZObpBokhbbFLPg1Omi+vs4m44w9Nrrp0voGXHVqyW70AqhOjfJk+F0v5t
         vv5M+vm5X6X5Lb3eHZ7qzFUKkq9+k/BF5LGGXarzpJj90oC1J7Yl69NIa0QrZ4sPL+3T
         f8X8xlCgikVDNSYMCfsANrYt3g3xsnxEAP+dyhfoYgoVITNtoVFpZTo7XGopIX7+oDVH
         Kc5w==
X-Gm-Message-State: AOAM533Jzqn1btl1yVHFSduwt3wCOGZEif6Ar3U8BvWpbxN8ddVq1Ruy
        C8cXqFvx4lwHJM3QcCHlumFWcpsdXHLprpIafWy2Bw==
X-Google-Smtp-Source: ABdhPJy6ktXt6Xg0XaKJVVWFESMKry/+PC9sS602Df8KIRW4F6BDs1kk2UPNtDcbLoWrpI9RZp0qu/RLjsRuRTk7z24=
X-Received: by 2002:a05:6830:2645:b0:5b0:2317:c738 with SMTP id
 f5-20020a056830264500b005b02317c738mr10692486otu.237.1646316089641; Thu, 03
 Mar 2022 06:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20220201223948.1455637-1-keescook@chromium.org> <164462189850.7606.6908949862618145181.b4-ty@oracle.com>
In-Reply-To: <164462189850.7606.6908949862618145181.b4-ty@oracle.com>
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date:   Thu, 3 Mar 2022 19:31:18 +0530
Message-ID: <CAK=zhgpQcJkRKVNFHy6mDqV9hOyzFsV_uqOWur8UsNLRZy-VdA@mail.gmail.com>
Subject: Re: [PATCH] scsi: mpt3sas: Convert to flexible arrays
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-hardening@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d1ac0f05d950d5ae"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d1ac0f05d950d5ae
Content-Type: text/plain; charset="UTF-8"

Hi,

I am observing below kernel panic when I load the driver with this
patch changes. After reverting this patch changes then the driver is
getting loaded successfully.

[  414.493579] mpt3sas_cm0: port enable: SUCCESS
[  414.498313] BUG: unable to handle page fault for address: 00000024000000ba
[  414.505182] #PF: supervisor read access in kernel mode
[  414.510322] #PF: error_code(0x0000) - not-present page
[  414.515462] PGD 0 P4D 0
[  414.518000] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  414.522360] CPU: 31 PID: 48 Comm: kworker/u98:0 Kdump: loaded
Tainted: G           OE     5.17.0-rc1+ #1
[  414.531833] Hardware name: Supermicro AS -1114S-WTRT/H12SSW-NT,
BIOS 1.1a 05/28/2020
[  414.539564] Workqueue: events_unbound async_run_entry_fn
[  414.544877] RIP: 0010:scsih_qcmd+0x29/0x450 [mpt3sas]
[  414.549938] Code: 00 0f 1f 44 00 00 41 57 41 56 41 55 41 54 55 48
89 fd 53 48 89 f3 48 83 ec 18 f6 87 91 08 00 00 40 0f 85 e3 00 05
[  414.568684] RSP: 0018:ffffa397c67df8d0 EFLAGS: 00010246
[  414.573912] RAX: 0000002400000012 RBX: ffff947666d84208 RCX: ffff947666d84208
[  414.581042] RDX: ffff947603afa000 RSI: ffff947666d84208 RDI: ffff947603afa000
[  414.588168] RBP: ffff947603afa000 R08: 0000000000000020 R09: ffff94764ad2fa30
[  414.595301] R10: 0000000000000000 R11: 0000000000000001 R12: ffff947603afa000
[  414.602434] R13: ffff947667d87000 R14: ffff947603afa000 R15: ffffa397c67df9d0
[  414.609568] FS:  0000000000000000(0000) GS:ffff947d2fbc0000(0000)
knlGS:0000000000000000
[  414.617654] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  414.623399] CR2: 00000024000000ba CR3: 00000004c9e0a000 CR4: 0000000000350ee0
[  414.630531] Call Trace:
[  414.632977]  <TASK>
[  414.635084]  scsi_queue_rq+0x36e/0xa70
[  414.638836]  blk_mq_dispatch_rq_list+0x2f6/0x8e0
[  414.643455]  ? get_page_from_freelist+0xb70/0xe50
[  414.648161]  ? __sbitmap_get_word+0x37/0x80
[  414.652347]  __blk_mq_sched_dispatch_requests+0xb2/0x140
[  414.657661]  blk_mq_sched_dispatch_requests+0x30/0x60
[  414.662712]  __blk_mq_run_hw_queue+0x34/0x90
[  414.666985]  __blk_mq_delay_run_hw_queue+0x18b/0x1c0
[  414.671949]  blk_mq_sched_insert_request+0xd3/0x140
[  414.676830]  blk_execute_rq+0x53/0xf0
[  414.680495]  __scsi_execute+0x101/0x260
[  414.684337]  scsi_probe_and_add_lun+0x181/0xe10
[  414.688869]  __scsi_scan_target+0xec/0x5a0
[  414.692969]  ? _raw_spin_unlock_irqrestore+0x1f/0x31
[  414.697933]  ? __pm_runtime_resume+0x54/0x70
[  414.702208]  scsi_scan_target+0xf8/0x110
[  414.706135]  sas_rphy_add+0x162/0x1b0 [scsi_transport_sas]
[  414.711620]  mpt3sas_transport_port_add+0x315/0x480 [mpt3sas]
[  414.717375]  _scsih_complete_devices_scanning+0x2f8/0x336 [mpt3sas]
[  414.723648]  scsih_scan_finished.cold.103+0x91/0xe3 [mpt3sas]
[  414.729393]  do_scsi_scan_host+0x6f/0x90
[  414.733321]  do_scan_async+0x17/0x150
[  414.736987]  async_run_entry_fn+0x30/0x130
[  414.741085]  process_one_work+0x1c8/0x390
[  414.745099]  worker_thread+0x30/0x350
[  414.748764]  ? process_one_work+0x390/0x390
[  414.752951]  kthread+0xe8/0x110
[  414.756098]  ? kthread_complete_and_exit+0x20/0x20
[  414.760891]  ret_from_fork+0x22/0x30
[  414.764469]  </TASK>
[  414.766662] Modules linked in: mpt3sas(OE) xt_CHECKSUM
xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nft_objref
nf_conntrack_tc
[  414.766715]  drm_ttm_helper ttm ahci crc32c_intel libahci drm
bnxt_en libata raid_class scsi_transport_sas pinctrl_amd dm_mirror d]
[  414.869470] CR2: 00000024000000ba

Thanks,
Sreekanth

On Sat, Feb 12, 2022 at 4:55 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> On Tue, 1 Feb 2022 14:39:48 -0800, Kees Cook wrote:
>
> > This converts to a flexible array instead of the old-style 1-element
> > arrays. The existing code already did the correct math for finding the
> > size of the resulting flexible array structure, so there is no binary
> > difference.
> >
> > The other two structures converted to use flexible arrays appear to
> > have no users at all.
> >
> > [...]
>
> Applied to 5.18/scsi-queue, thanks!
>
> [1/1] scsi: mpt3sas: Convert to flexible arrays
>       https://git.kernel.org/mkp/scsi/c/d20b3dae630f
>
> --
> Martin K. Petersen      Oracle Linux Engineering

--000000000000d1ac0f05d950d5ae
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
5AGo2E3pe+2yEgkxKvM2fnniZHUiSjbrfKk6nl9RIXPOKUP5HntZFdA5XuNYXWM+HPs3O0AJwBm/
VCZsZtkjVjxeBmTXiXDnxytdsHdGrHGymPfjJYatDu6d1KRVDlMCAwEAAaOCAd0wggHZMA4GA1Ud
DwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggr
BgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3
Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmww
JwYDVR0RBCAwHoEcc3JlZWthbnRoLnJlZGR5QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUClVHbAvhzGT8
s2/6xOf58NkGMQ8wDQYJKoZIhvcNAQELBQADggEBAENRsP1H3calKC2Sstg/8li8byKiqljCFkfi
IhcJsjPOOR9UZnMFxAoH/s2AlM7mQDR7rZ2MxRuUnIa6Cp5W5w1lUJHktjCUHnQq5nIAZ9GH5SDY
pgzbFsoYX8U2QCmkAC023FF++ZDJuc9aj0R/nhABxmUYErIze2jV/VO8Pj7TnCrBONZ/Qvf8G5CQ
X1hfOcCDBgT7eSvf9YRLaV935mB9/V+KYX8lT4E0lB4wQ0OLV8qUS9UuNoG2lCJ5UQTMrBgeUFFY
eKKhn+R91COmRlKGlaCdTtzKG5atS6dPnGEYUHjcpUvzejmJ5ghBk6P01HqSACsszDOzmBvdiOs+
Ux0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxyeqr1
0keLkvPdYw4wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIN06xAWm+gj0yPI0/yC
BpkVQmMk7HHzaP4KvyXjfesTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIyMDMwMzE0MDEzMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCfLbrt2Awk8IISnf8A5cNysZGggdNjK5cdXtVN
TYDoSS7MUJTVjCM7C3bRftBFF9A5oZ6qXNK6vfxO8Nfw6UjGicc72q2UI4lSYa+48tEhTNd93uSq
GxIxgfIKh17kouHH+lHTx5OMIQRiFjMVnSyvRVV8v6jVsvf5vb0WE6XiwYumhusBjp+qelIrYp1L
w6ObkMaxfPNIF7qGaVp4ZUb5nHtmgLVIqljPOzIbouD+YVC9R11L/NaTjjRh4uziohbwlZUt8mwV
xNtYR1YRyu//8jek8UUA4DBjMohX6UFG36uqgJLqJ2Fwh8JFeYHBgZhnVhIKygcbQbz/lcscz552
--000000000000d1ac0f05d950d5ae--
