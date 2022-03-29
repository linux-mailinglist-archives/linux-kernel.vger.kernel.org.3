Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65254EAEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiC2NlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbiC2NlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:41:23 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156A81CFF0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:39:41 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id i4so15221609qti.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=tPpKSwJDTiQu2sjMGweoZsTG1xECoNDnnovlQrFXi0M=;
        b=ngXzcXYr3VLU93q+PFtfdVbc6m/o8JZPfcyXHs/hlu4sngWknmhnHYX9BzZoXPhaTO
         Gib1W114ack8O/YacQ+98zxn+aa+Tim7jsQfsjLrm6Zf2NJc1P/FPUT5hZS2fyF6zESY
         FqxW5RDMFFj4Uap2Q0IPMBwZnvsJ/G5zFgNmWiIi5zH7SZD9wp1owMjM2uDH3qzCl9t1
         Mz//C12ZfzbjbQhx5GdERHy3t9KfIRUvPNZWsAmuXI0szqED8uv/GHibzcObAESLnxoJ
         ETJjRt9IZ/bdGd2o/dQsAsDBSJRbN/lW5wWx5KHly0HEqIGJF4yYQ47zQAy+nMXQlHu4
         jPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=tPpKSwJDTiQu2sjMGweoZsTG1xECoNDnnovlQrFXi0M=;
        b=vYv30rG+MzK8hjPSVft7YVcQiPnw3xYEzIUT2pvytFNSfpKCURCwqA8EMdRxn64b2e
         Eil6yFFaw4umkk559EvNslfyqEro9flsAdNOKmUTjHaPH6QlnkIFRXEc/tk8t4fg43fb
         jAh4w3/1tubZjSIrv0dkvMqyuNlxYv3hDqXj60Z+2EU+e6P/+OfmiIK5oNmwl8gjOFDv
         VutZsjVsVmcaDocQqz3eW+tZGv9m7od24mQWsrmtzvhDgtEV2/V87o22hfxTCEYlusE9
         UsntEavKX7KMXeOk0s9OrdLh2wgIxRqkYX3feQLGfSpTQ5QDPpdblFjguNzAt7ShfTIk
         yheA==
X-Gm-Message-State: AOAM531u/HU+pfgIzXv8L0Comtfs4mJ/QoBBPzWRjXvBsqHjvF3wuTf5
        zIMoGcHMNPOM1o3oDiLhNErN6PpGi7gsmy5q
X-Google-Smtp-Source: ABdhPJwFvvcHyL6sk2op7ok5D3neOdXRDaDWdU13bBRPyD2LNfnc6hSW/RNdei+LKXxfy9ynoHRTjg==
X-Received: by 2002:a05:622a:587:b0:2e2:38d6:ca75 with SMTP id c7-20020a05622a058700b002e238d6ca75mr27451666qtb.415.1648561180240;
        Tue, 29 Mar 2022 06:39:40 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id b82-20020ae9eb55000000b0067b314c0fedsm10039714qkg.42.2022.03.29.06.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:39:39 -0700 (PDT)
Message-ID: <c158787c2950b4fe03477ac261067ca5600e7bc0.camel@ndufresne.ca>
Subject: Re: [PATCH] staging: media: hantro: Update TODO list
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Mar 2022 09:39:38 -0400
In-Reply-To: <20220326183715.67332-1-sebastian.fricke@collabora.com>
References: <20220326183715.67332-1-sebastian.fricke@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 26 mars 2022 =C3=A0 19:37 +0100, Sebastian Fricke a =C3=A9crit=C2=
=A0:
> VP8 has been added to the uABI by 363240ce1c08
> VP9 has been added to the uABI by b88dbe38dca8
> H264 has been added to the uABI by 46a309d27517
>=20
> The last remaining codec to be added to the uABI is HEVC.
> Highlight these changes in the TODO list.
>=20
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/staging/media/hantro/TODO | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/staging/media/hantro/TODO b/drivers/staging/media/ha=
ntro/TODO
> index 1d7fed936019..8483ff482146 100644
> --- a/drivers/staging/media/hantro/TODO
> +++ b/drivers/staging/media/hantro/TODO
> @@ -1,6 +1,2 @@
> -* Support for VP8, VP9 and H264 is planned for this driver.
> -
> -  Given the V4L controls for those CODECs will be part of
> -  the uABI, it will be required to have the driver in staging.
> -
> -  For this reason, we are keeping this driver in staging for now.
> +The V4L controls for the HEVC CODEC are not yet part of the stable uABI,
> +we are keeping this driver in staging until the HEVC uABI has been merge=
d.

