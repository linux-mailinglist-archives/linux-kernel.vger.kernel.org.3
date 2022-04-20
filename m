Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23443508C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380352AbiDTPym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380346AbiDTPyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:54:40 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E474093C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:51:53 -0700 (PDT)
Date:   Wed, 20 Apr 2022 15:51:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1650469911;
        bh=0ixJXXvnTgsn0qDHr6/TrGav1WNXehlytEOiTCtxmF0=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=mTLL0lfK5o9bnjeTxBBFyrm4t3CjTJtirqcbNrZZw3S3uPtA1PIeQLvb2W8YbbDhE
         vcreQA2TpMKmNRF4yPMItYBBAFkdsmTasIf4GtiEe23MVIpUMNX9ev/phxfgZTJX8W
         XG7e1uCDjFtQzJ/bDMuCkHtLp64v0qMoob3Baz/P7OkEvSTv0LhyNyPM4LUYHjAEyN
         wAMHMN9mw4yVTBBdr0Ui8SEEXqZPi121jOF4oaEazvAaFG0txgMFxp5Jm+pyw9xcgC
         pGxqhv3hSIF8SH1dsqq7dzbUXF+sB+tVna770ma1mO3qT4Vu+2NfMs1MTKAhyye+/a
         Ifab719HOn/3A==
To:     Guenter Roeck <linux@roeck-us.net>
From:   wujek dev <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: wujek dev <dev_public@wujek.eu>
Subject: Re: [PATCH 2/2] hwmon: (pmbus) add MFR_* registers to debugfs
Message-ID: <Liq6d7nBil1lQx274diOvpjRJ9cEYH6co7ZMjrudPfYn0TTzOsfqsjuVBK-pMpFF5nBC0jhuoFEtbtmUY4Td4uY-a4qn6j-OmQD-Qu_xdck=@wujek.eu>
In-Reply-To: <6f697b2c-58aa-6ca4-966b-147bcc184dad@roeck-us.net>
References: <20220419215326.309991-1-dev_public@wujek.eu> <20220420122128.411757-1-dev_public@wujek.eu> <f34ec7ac-7b34-6d98-25ad-31b13fe08c59@roeck-us.net> <PFzjnraIDClF6umMOqlCKCzxG6q5lIhBLHpynRA6juh6gXSp5Y7SLPpzXZGNU6L7OGCEwl_F-niJn1jTflifWnqm9PX3Rcfqbtdo6rmPAT4=@wujek.eu> <6f697b2c-58aa-6ca4-966b-147bcc184dad@roeck-us.net>
Feedback-ID: 23425257:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------- Original Message -------
On Wednesday, April 20th, 2022 at 16:15, Guenter Roeck <linux@roeck-us.net>=
 wrote:


>
>
> On 4/20/22 06:58, wujek dev wrote:
>
> > ------- Original Message -------
> > On Wednesday, April 20th, 2022 at 15:53, Guenter Roeck linux@roeck-us.n=
et wrote:
> >
> > > On 4/20/22 05:22, Adam Wujek wrote:
> > >
> > > > Add registers to debugfs:
> > > > PMBUS_MFR_ID
> > > > PMBUS_MFR_MODEL
> > > > PMBUS_MFR_REVISION
> > > > PMBUS_MFR_LOCATION
> > > > PMBUS_MFR_DATE
> > > > PMBUS_MFR_SERIAL
> > > >
> > > > Signed-off-by: Adam Wujek dev_public@wujek.eu
> > >
> > > Where is patch 1/2, and why did you resend this patch ?
> >
> > There should be no "1/2" since this and the second patch are unrelated.
> > I resend it because I rebased it on master.
>
> Please provide change logs and version your patches in the future.
ok, thank you for your patience.
>
> > Adam
> >
> > > Guenter
> > >
> > > > ---
> > > > drivers/hwmon/pmbus/pmbus_core.c | 84 +++++++++++++++++++++++++++++=
+++
> > > > 1 file changed, 84 insertions(+)
> > > >
> > > > diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus=
/pmbus_core.c
> > > > index 0af7a3d74f47..1dc186780ccf 100644
> > > > --- a/drivers/hwmon/pmbus/pmbus_core.c
> > > > +++ b/drivers/hwmon/pmbus/pmbus_core.c
> > > > @@ -2625,6 +2625,30 @@ static int pmbus_debugfs_get_status(void *da=
ta, u64 *val)
> > > > DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_status, pmbus_debugfs_ge=
t_status,
> > > > NULL, "0x%04llx\n");
> > > >
> > > > +static ssize_t pmbus_debugfs_mfr_read(struct file *file, char __us=
er *buf,
> > > > + size_t count, loff_t *ppos)
> > > > +{
> > > > + int rc;
> > > > + struct pmbus_debugfs_entry *entry =3D file->private_data;
> > > > + char data[I2C_SMBUS_BLOCK_MAX + 2] =3D { 0 };
> > > > +
> > > > + rc =3D i2c_smbus_read_block_data(entry->client, entry->reg, data)=
;
> > > > + if (rc < 0)
> > > > + return rc;
> > > > +
> > > > + data[rc] =3D '\n';
> > > > + rc +=3D 2;
>
>
> Why +2 ?
>
Copied from another driver.
+1 due to '\n'
+1 due to NULL character (smbus block transfer does not include it in the l=
ength)
Explanation included in v3 patch.
> > > > +
> > > > + return simple_read_from_buffer(buf, count, ppos, data, rc);
> > > > +}
> > > > +
> > > > +static const struct file_operations pmbus_debugfs_ops_mfr =3D {
> > > > + .llseek =3D noop_llseek,
> > > > + .read =3D pmbus_debugfs_mfr_read,
> > > > + .write =3D NULL,
> > > > + .open =3D simple_open,
> > > > +};
> > > > +
> > > > static int pmbus_debugfs_get_pec(void *data, u64 *val)
> > > > {
> > > > struct i2c_client *client =3D data;
> > > > @@ -2801,6 +2825,66 @@ static int pmbus_init_debugfs(struct i2c_cli=
ent *client,
> > > > &entries[idx++],
> > > > &pmbus_debugfs_ops);
> > > > }
> > > > +
> > > > + if (pmbus_check_byte_register(client, i, PMBUS_MFR_ID)) {
> > > > + entries[idx].client =3D client;
> > > > + entries[idx].page =3D i;
> > > > + entries[idx].reg =3D PMBUS_MFR_ID;
> > > > + scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_id", i);
> > > > + debugfs_create_file(name, 0444, data->debugfs,
> > > > + &entries[idx++],
> > > > + &pmbus_debugfs_ops_mfr);
> > > > + }
>
>
> You are adding several debugfs entries without increasing the size
> of the entries array. That means that up to 16 debugfs entries are
> now created into an array of size 10. That won't work.
You're right, I just sent another patch.

Adam
>
> Guenter
