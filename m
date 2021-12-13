Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C8C472D04
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbhLMNPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbhLMNPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:15:12 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31769C0613F8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:15:12 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 193so13766166qkh.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=fWyZSNi0So5hVX2b7kcztoVxQqD+EfAcdT01DBWMIo4=;
        b=cYyZtHa6E6IL7apVQqL4Gx/7WakFk7mmkZi3npGtqg2sy9IDi3fm0+Zj6cKYf2iPG2
         3J08dvqf9LbXRi5xe5BtyQxD94GuMHaGWH8hRmn23Js6aavO4E9oGbk50Ya2g8Th1hi8
         sU5FDueXULq9S9KVgGBpVG0mL8KfZJVnKNX0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=fWyZSNi0So5hVX2b7kcztoVxQqD+EfAcdT01DBWMIo4=;
        b=u5/xDZOxxFvMgtbO5N1YvfnL0c7sxl4reE2NWfkMkSqa1N3HU9JbWcnA1fdwNS/mvB
         hJLdu/7hixyicCZD9eoAUmUah0pQT9Bx7oC9c7vTHANC0peSkK7eBYI7hSl0Ed6tiz5E
         t6/oSrDm3yf7kjlO7OSc+8fSBfy3+lCoElIT7l0EFxL3LRsx+h3dP+FUSW7ddP7xSpCu
         5DoAlj3LvtiATyO1kS6MaiILsQki4LucJS8WepL19CO8JTN6DcGC11TPBlc9TtyDmMPT
         +SQB5HTImLBANAlsZnLV1VYaFdXEZu2f6Wh14+WGlHMPJ4vY5aaCFTRL8qN7Q+J1E8KO
         8UPQ==
X-Gm-Message-State: AOAM531skZG2ZnOKAfGEWKSEIcnpHnoefGRoSnza6B/IqnuGZQDGGo1Z
        rm4W3qnzW+kA8WXWxw3DcR8ju3QMej4x0b4+Z3XcLQ==
X-Google-Smtp-Source: ABdhPJwd00JUZHFaX58oUeC9BKtVkqVdjWEqcjw+A5+3N1+oG49i0xrFh+pr9MxmNpYTkmC2YUV3KVVHgR6y81OxdCY=
X-Received: by 2002:a05:620a:8c7:: with SMTP id z7mr31770212qkz.772.1639401311206;
 Mon, 13 Dec 2021 05:15:11 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <1634550083-202815-1-git-send-email-john.garry@huawei.com>
 <163482611742.37241.15630114014516067630.b4-ty@kernel.dk> <0b928f7dbc2f3244afe8a475b547157f@mail.gmail.com>
 <3389cd7b-2934-8e82-b09a-a4fdb0f00ea3@huawei.com>
In-Reply-To: <3389cd7b-2934-8e82-b09a-a4fdb0f00ea3@huawei.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQH6ME5L8xUsgQGWU+HICvNEbBVHbgMhOjIaAXUFTUMCYESnuau0LnwQ
Date:   Mon, 13 Dec 2021 18:45:09 +0530
Message-ID: <deaaac7e5bcce4046725528bc250a799@mail.gmail.com>
Subject: RE: [PATCH v2] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
To:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.de, ming.lei@redhat.com, linux-scsi@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d1d0bd05d306dce3"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d1d0bd05d306dce3
Content-Type: text/plain; charset="UTF-8"

> On 09/12/2021 13:52, Kashyap Desai wrote:
> > + scsi mailing list
> >
> >> On Mon, 18 Oct 2021 17:41:23 +0800, John Garry wrote:
> >>> Since it is now possible for a tagset to share a single set of tags,
> >>> the iter function should not re-iter the tags for the count of #hw
> >>> queues in that case. Rather it should just iter once.
> > John - Recently we found issue of error hander thread never kicked off
> > and this patch fix the issue.
> > Without this patch, scsi error hander will not find correct host_busy
> > counter.
> >
> > Take one simple case. There is one IO outstanding and that is getting
> > timedout.
> > Now SML wants to wake up EH thread only if, below condition met
> > "scsi_host_busy(shost) == shost->host_failed"
> >
> > Without this patch, shared host tag enabled meagaraid_sas driver will
> > find host_busy = actual outstanding * nr_hw_queues.
> > Error handler thread will never be kicked-off.
> >
> > This patch is mandatory for fixing shared host tag feature and require
> > to be part of stable kernel.
> >
> > Do you need more data for posting to stable kernel ?
>
> To be clear, are you saying that you see the issue which patch "blk-mq:
> Fix blk_mq_tagset_busy_iter() for shared tags" fixes before v5.16-rc?
>
> This patch (now commit 0994c64eb415) and the commit which it is supposed
> to fix, e155b0c238b2, will only be in v5.16, so I don't see anything which
> is
> needed in stable.

Hi John

Yes. No need of posting this to stable.  There is still an issue which we
are tracking. It is not always reproducible. I am injecting artificial Task
abort on my setup to reproduce it.
It happens on rhel8.5 most of the time. It is a timing issue so thinking of
reproducing on other kernel as well.
I am suspecting issue might be due to  missing commit -
67f3b2f822b7e71cfc9b42dbd9f3144fa2933e0b of  [PATCH] blk-mq: avoid to
iterate over stale request

Whenever I notice the issue, there was a symptoms that host_busy is getting
counted for each hctx individually. Let me collect more data and I will
start another thread.

Kashyap

>
> Thanks,
> John

--000000000000d1d0bd05d306dce3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPBDTv3SUsB0oxl5KRln5tMvO/YI
e8KL3j99PpTVektBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MTIxMzEzMTUxMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCuy6GPZ4EKBxYJi9c4uq8HS+FEpvXPvLq45rFv9uFp8Wui
LEX7RAydYisNKBgzwDHYQ87Ag3VFDoGvFIB7mzSLtLG6Pd8wAC/PEowLTzm8CDy1LmhdAezYQyzN
TKQDl1fM2VfOu8yNagfPvRgdM5CiPD1GSOHtkG+HDFGu5mB/QBj2lzmIigNZ9VCFIjNF1XIms6Wl
ZWdFRBTS+0rkPQ7zvdG4kjCVAWWyi3A/kz+F1MIZkNm23ngYENk0BQXENLQDBZj2X5gg/MmnGaja
ipBI7EJY+hjN1YfeaKJRQrvJOW+MUz0K8N+jJMVtv00lAETW+iqbCgpezYdYiqHIa4zT
--000000000000d1d0bd05d306dce3--
