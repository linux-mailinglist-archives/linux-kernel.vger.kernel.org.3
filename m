Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3606A479C3B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhLRS5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:57:22 -0500
Received: from sonic304-24.consmr.mail.gq1.yahoo.com ([98.137.68.205]:37231
        "EHLO sonic304-24.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231234AbhLRS5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1639853841; bh=ystPiyuNszK8iHadvVOScsEWg8u8AIK+cdqBwVbBTiI=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=MI59WOxaV1KAegzeAH4mzhwzeXN8ePjUTUQABrKEw3t6eFKHfHowBSNCwMScusMMeNPGS8PSA4Laoxv5BLVVTSIBmV2RdaLkJKpIEmwci/ejRUVw71N2kNWWgPxCoigaDSnakS/UmI+5O4NWADPWjCWnUPKvfTqp/STiFlyTA2OG2sam3xRtDxXG+Zd2lvjN94dAo3dNQHVvNuihpx8uK3Q/t5n4glwmJfB3mWtF9Bq91z67v1REDgorJGfCeMCcqzh0TeOQEBxurVU0v9uM2Eu9B+J/TihrhwUMbWx7Plkwy2kNDjVDeFSqU2HKxRaL4S9legWJ7B26bo3anaivBA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639853841; bh=yxruNo7iVx70/a3YhfLsxQ7egk0sJI6sW+9Y5NDbsG5=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=lZ+QhCr6u2MtmSWbloIOb4RqB19vNiUu0ec7T5jzQ75fOO6ir+o7QrRfBcf6kpVIMqKyd3A1x34J9G8yBla12+CzWYvKlPQeq7wqScOnjbbQSSgHIbqC+H16TELV5LBy1Fb5jKwk+T6auFWn7wpQmrZbdW8Iyb3EqUqBA1CrHc2DnNtjoHFxfaL+3Aae+eIA6kx98hnNeH0BRsdiDg1caLbjtvpjgiesEY2ak/CopayIVkOKDV6nyfp7Qzd3rfAwyCR/pauC7LSIfVgJ6CEtnN4ZwUTKcKz/0UcftnBqjwGLKm6/syRrA5uJ3aA+9RirJ6FfsB/Dy2jYf7w4WWkHtg==
X-YMail-OSG: DY0c6mMVM1mXsIevQbZPASoqw7yKkdz.V9P72TAMjPFqRqUFWPWgrqf7xr0u978
 EQsmUhDhTedYDFEsZMbBAtITGtDRH_T009vnw4NGgpKUdDAsaVBtloqMsqQ_JugfSnuYjrpDm3FS
 Pv4WieRDeUi9gB8X_PplyeLGQ2jA3kml6STGyNc3VURP1DFje1YYc7.B2GTc_dBmadFthas9hLlC
 D5fj.UO0oSskUVd7eXq2EjqIB9BygZ69XElkK4gn7QoacXaWx172n4JxVGtS8JfZ8r8M5m3uNOlp
 oRozX0cQgj.uh2oGZTOZeutfPj_YFhXdr_JE1fbVH4t2Jp9KpX.fIVyuPdRDjF2tmy1_Ie8g0UV_
 _732E5WguVK5XOrzVbmfPHGUoLLzoKfkITlGIi0OE5REEt8kBY6U1q_XACAlSO3Rj7mvQHRE9zbp
 WKxhLpF78xyOkFb0PdDGXhvMb7wk8sznxYCkdnKdufUjRzREDXww_W0l8wAYt7MLQ9EGjFR8dspo
 Cf7CoJZJDrWLiqTfmym_EgKEGYD4fdzbYrGQJMiQd1pqIMuTh2RO1K9JXX74OFiKa3SQOmGEtTXO
 RvlfjNrhC7HFEfYb_4xISfpVW_829Vnr_QY1QyBl_aobeCB.lNMQdbXwrfysb_0nEyQrnzSHJDjK
 NuWopN8WXwY0JTYdmsYuyfulyYJKvuLjLBkJgIP0PoQFrvDRu_q86lT_l9BQgjcyVVsVvnJWwEyV
 Le6QTqfyNb0147BBGgTTfJY9qvk5CU5dKlg_L8HgY4wzy5Uj_awyERzkesDOE_XC84n.LSds_2Al
 P161mc6bb7njk7Dnxl7_SQiJyc2HzMQJGi5qtOirVvCEQHM6soFXBz6k.LdZH41gd_CuuxUDd3_7
 xbIyRa4RoKDjWSMTAI6dVTkggC.N2Q6gbvqm4F7R_Rkv_NsmdgKt7nJJIunAP8KbQXqumGokd5LU
 bXuM3y6PnZXj6ajozz1epmWrGEUtXUifoyrbiEFRXPrNac1Isd3l11vxf8_fvcAE8yKW8AnLq_6v
 D4whvPDkDxKqOMHVFhwfglMiLdv0X03NLnPN8a0V0v4oS3E37566_3fqPGEwL3_VGyuocipyXHHP
 qkoG0_aJJIWkJDJARv22JPANuyQw6XiuQXcEZMYGBzodG1i8KIQHAhgQYiHh42TWaLX7vfHe1Xcv
 8wL6CLut37G_JLNGwi9YpzbSYNHZt9qczqlzag8vQkxwVYtuuNbkE_JuEQTcWBRqn809GlKqpdBO
 o43s2gxQToW1f.5YhFAYQiQISS18ajLjHg19fgvfzWtpL0fbXYXroxFa.5Ln4KsFM3vDUv9gxSMn
 2wMhGGRzWo3Gy_O3NAXkL9Py5o6gWlRxIVf6z1nD9Z0_bkOkyZHnCL3MbkbiLWNwZovn6OaJzbV9
 leHKBee6Wbfu_g192PEKhtHL4yIUosuRAC1UVPWpWFIuvRYccEurmSi8yTvVJ4K3quiWWF4b25eb
 yjP6D3LVN3AqCOTJdnYGxybv2bTY3GW.NMX4fJp5..u75m.c5J0W2H29NVBEi0IRNlHn9DV08Qeo
 PbFb8j2Uv6IPG7dpDP63xz4bAvPOA9FmgJKAaAIGRq3Gs8KKuXAXLd.MSFTyO8vu2hzuwJOaTQ2E
 Lskl0KNy4pZBKPM4iWw.fjexKEYFOZoFdVC41LksWQOz4EYLwe_CVJ3m7VYXyZW39lMI_Hia_XZ9
 Zb4ZQQDK2yXvryU.eKkcQg8ndrsIJMMhjV4BtPgx54mHDoQQ4VcK0MICh_xCJqQyv18rEEqzAYsq
 uxnx0MVJy1dZf68Pd5KuPTsmOyj3pd54Iz0rf.XkBEXvj3UEIfr9MTh51Kf0ghK79hok8zwU_kDe
 KUJ4DoewfgHAOecjjvExm2P_6xR4_fzKDLj7m_YYNREBVbCd54QixRoO6jC8rMW8Dg5UpMyjH_WB
 L6OoyN0vcxGp25zzT22cH8_Ag01EWu92kX4YWawyLl0HqUuxWu_afUaPzAKKi6X6iww.gu8K0Gul
 srGr7ASzT8O0CNIJv_7gFKzUzSDZb3kKBukB.h06IpukmkRctqmJ7Bpu5gnmQXDQMUgu1N55sZbp
 zuNjty1qgBp9r8uR_WX.8Zzyp330BttCQ50UlpAS.JcCKV0REEwJ2B01l6mtyR6pxMLvJUZ89h.Z
 WiM5TLhh3TRxjwwKm5Zu6Z5FR28Kfdsp0o3pML1ok3gS5hYc4RYLf8gKDTvYKQEOe2gmEJuia8sP
 DTEiOCU.4uSItBfpTt6z722Leiaeq9fPOmfYxdSMcJFuOkFxpNtTBOve724XIow--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 18 Dec 2021 18:57:21 +0000
Received: by kubenode502.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7ac5fbc290389f15e626e256a23c2fd7;
          Sat, 18 Dec 2021 18:57:18 +0000 (UTC)
Date:   Sat, 18 Dec 2021 13:57:15 -0500
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: very low IOPS due to "block: reduce kblockd_mod_delayed_work_on() CPU
 consumption"
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dexuan Cui <decui@microsoft.com>, ming.lei@redhat.com,
        hch@lst.de, Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <1639853092.524jxfaem2.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1639853092.524jxfaem2.none.ref@localhost>
X-Mailer: WebService/1.1.19415 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently noticed that between 6441998e2e and 9eaa88c703, I/O became=20
much slower on my machine using ext4 on dm-crypt on NVMe with bfq=20
scheduler. Checking iostat during heavy usage (find / -xdev and fstrim=20
-v /), maximum IOPS had fallen from ~10000 to ~100. Reverting cb2ac2912a=20
("block: reduce kblockd_mod_delayed_work_on() CPU consumption") resolves=20
the issue.

Thanks,
Alex.
